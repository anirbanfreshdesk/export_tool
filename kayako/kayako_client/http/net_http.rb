#######################################################################
#
# Kayako Ruby REST API library
# _____________________________________________________________________
#
# @author      Andriy Lesyuk
#
# @package     KayakoClient
# @copyright   Copyright (c) 2011-2013, Kayako
# @license     FreeBSD
# @link        https://github.com/kayako/ruby-api-library
#
#######################################################################

require 'net/https'

module KayakoClient
    class NetHTTP
        include KayakoClient::Logger
        include KayakoClient::HTTPBackend

        def initialize(options = {})
            @client = Net::HTTP::Proxy(options[:host], options[:port], options[:user], options[:pass])
            @logger = options[:logger] if options[:logger]
        end

        def get(base, params = {})
            uri = URI.parse(base)
            log = params.delete(:logger) || logger
            session = @client.new(uri.host, uri.port)
            session.use_ssl = true if uri.is_a?(URI::HTTPS)
            resp = session.start do |request|
                query = url(uri.path, params)
                log.debug ":get => #{query}" if log
                request.get(query)
            end
            response(resp)
        end

        def put(base, params = {})
            uri = URI.parse(base)
            e = params.delete(:e)
            log = params.delete(:logger) || logger
            session = @client.new(uri.host, uri.port)
            session.use_ssl = true if uri.is_a?(URI::HTTPS)
            resp = session.start do |request|
                query = url(uri.path, { :e => e })
                data = form_data(params)
                if log
                    log.debug ":put => #{query}"
                    log.debug "PUT Data: #{data}"
                end
                request.put(query, data, 'Content-Type' => 'application/x-www-form-urlencoded')
            end
            response(resp)
        end

        def post(base, params = {})
            uri = URI.parse(base)
            e = params.delete(:e)
            log = params.delete(:logger) || logger
            session = @client.new(uri.host, uri.port)
            session.use_ssl = true if uri.is_a?(URI::HTTPS)
            resp = session.start do |request|
                query = url(uri.path, { :e => e })
                data = form_data(params)
                if log
                    log.debug ":post => #{query}"
                    log.debug "POST Data: #{data}"
                end
                request.post(query, data, 'Content-Type' => 'application/x-www-form-urlencoded')
            end
            response(resp)
        end

        def delete(base, params = {})
            uri = URI.parse(base)
            log = params.delete(:logger) || logger
            session = @client.new(uri.host, uri.port)
            session.use_ssl = true if uri.is_a?(URI::HTTPS)
            resp = session.start do |request|
                query = url(uri.path, params)
                log.debug ":delete => #{query}" if log
                request.delete(query)
            end
            response(resp)
        end

        def response(resp)
            case resp
            when Net::HTTPOK
                KayakoClient::HTTPOK.new(resp.body)
            when Net::HTTPBadRequest
                KayakoClient::HTTPBadRequest.new(resp.body)
            when Net::HTTPUnauthorized
                KayakoClient::HTTPUnauthorized.new(resp.body)
            when Net::HTTPForbidden
                KayakoClient::HTTPForbidden.new(resp.body)
            when Net::HTTPNotFound
                KayakoClient::HTTPNotFound.new(resp.body)
            when Net::HTTPMethodNotAllowed
                KayakoClient::HTTPNotAllowed.new(resp.body)
            else
                KayakoClient::HTTPResponse.new(resp.code, resp.body)
            end
        end

    private

        def urlencode(string)
            URI.escape(string, Regexp.new("[^#{URI::PATTERN::UNRESERVED}]"))
        end

        def url(base, params = {})
            base + '?' + params.collect { |name, value| urlencode(name.to_s) + '=' + urlencode(value.to_s) }.join('&')
        end

        def form_data(params = {})
            params.collect { |name, value|
                value.is_a?(Array) ?
                    value.collect { |item| urlencode(name.to_s) + '[]=' + urlencode(item.to_s) } :
                    urlencode(name.to_s) + '=' + urlencode(value.to_s)
            }.join('&')
        end

    end
end
