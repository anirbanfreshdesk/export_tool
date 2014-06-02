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

require 'kayako_client/user_group'
require 'kayako_client/user_organization'

module KayakoClient
    class User < KayakoClient::Base

        USER_ROLES       = [ :user, :manager ].freeze
        USER_SALUTATIONS = [ 'Mr.', 'Ms.', 'Mrs.', 'Dr.' ].freeze

        # NOTE: if :user_group_id is set the group should be of :registered type

        property :id,                   :integer, :readonly => true
        property :user_group_id,        :integer, :required => :post
        property :user_role,            :symbol, :in => USER_ROLES
        property :user_organization_id, :integer
        property :salutation,           :string, :in => USER_SALUTATIONS
        property :user_expiry,          :date
        property :full_name,            :string, :required => [ :put, :post ]
        property :emails,             [ :string ], :required => :post, :get => :email, :set => :email
        property :designation,          :string
        property :phone,                :string
        property :date_line,            :date, :readonly => true
        property :last_visit,           :date, :readonly => true
        property :is_enabled,           :boolean
        property :time_zone,            :string
        property :enable_dst,           :boolean
        property :sla_plan_id,          :integer
        property :sla_plan_expiry,      :date
        property :password,             :string, :new => true, :required => :post
        property :send_welcome_email,   :boolean, :new => true

        associate :user_group,          :user_group_id,        UserGroup
        associate :user_organization,   :user_organization_id, UserOrganization

        def self.all(marker = nil, limit = nil, options = {})
            unless marker.nil?
                unless marker.to_i > 0
                    logger.error "invalid :marker - #{marker}" if logger
                    raise ArgumentError, "invalid marker"
                end
                unless limit.nil? || limit.to_i > 0
                    logger.error "invalid :limit (:maxitems) - #{limit}" if logger
                    raise ArgumentError, "invalid limit"
                end
            else
                if limit && limit.to_i > 0
                    logger.error "invalid :marker" if logger
                    raise ArgumentError, "missing marker"
                end
            end

            e = path + '/Filter'
            if marker
                e << "/#{marker.to_i}"
                e << "/#{limit.to_i}" if limit
            end
            super(options.merge(:e => e))
        end

        def self.search(query, options = {})
            unless configured? || (options[:api_url] && options[:api_key] && options[:secret_key])
                raise RuntimeError, "client not configured"
            end
            raise ArgumentError, "query can't be empty" if query.empty?

            response = post_request(options.merge(:e => '/Base/UserSearch', :query => query))
            log = options[:logger] || logger
            if response.is_a?(KayakoClient::HTTPOK)
                objects = []
                if log
                    log.debug "Response:"
                    log.debug response.body
                end
                payload = xml_backend.new(response.body, { :logger => log })
                payload.each do |element|
                    object = new(payload.to_hash(element).merge(inherited_options(options)))
                    object.loaded!
                    objects << object
                end
                log.info ":post(:search, '#{query}') successful (#{objects.size} objects)" if log
                objects
            else
                log.error "Response: #{response.status} #{response.body}" if log
                raise StandardError, "server returned #{response.status}: #{response.body}"
            end
        end

    end
end
