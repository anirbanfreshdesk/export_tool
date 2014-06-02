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

require 'base64'
require 'time'

module KayakoClient

    class TicketCustomFieldValue < KayakoClient::Tickets

        property :id,        :integer, :readonly => true
        property :type,      :integer, :readonly => true, :range => 1..11
        property :title,     :string, :readonly => true
        property :name,      :string, :readonly => true
        property :file_name, :string, :readonly => true
        property :contents,  :string

        def initialize(*args)
            super(*args)
            if defined?(@type)
                if @type == KayakoClient::CustomField::TYPE_FILE
                    self.class.send(:include, KayakoClient::Attachment)
                    if defined?(@contents)
                        logger.debug "decoding base64 :contents" if logger
                        @contents = Base64.decode64(@contents)
                        @contents = Base64.decode64(@contents)
                    end
                elsif @type == KayakoClient::CustomField::TYPE_DATE
                    @contents = Time.parse(@contents) if defined?(@contents)
                end
            end
        end

    end

    class TicketCustomFieldGroup < KayakoClient::Tickets

        property :id,            :integer, :readonly => true
        property :title,         :string,  :readonly => true
        property :display_order, :integer, :readonly => true

        property :fields, [ :object ], :class => TicketCustomFieldValue, :get => :field

    end

    class TicketCustomField < KayakoClient::Tickets
        supports :get, :post

        TYPE_TEXT          = KayakoClient::CustomField::TYPE_TEXT
        TYPE_TEXT_AREA     = KayakoClient::CustomField::TYPE_TEXT_AREA
        TYPE_PASSWORD      = KayakoClient::CustomField::TYPE_PASSWORD
        TYPE_CHECKBOX      = KayakoClient::CustomField::TYPE_CHECKBOX
        TYPE_RADIO         = KayakoClient::CustomField::TYPE_RADIO
        TYPE_SELECT        = KayakoClient::CustomField::TYPE_SELECT
        TYPE_MULTI_SELECT  = KayakoClient::CustomField::TYPE_MULTI_SELECT
        TYPE_CUSTOM        = KayakoClient::CustomField::TYPE_CUSTOM
        TYPE_LINKED_SELECT = KayakoClient::CustomField::TYPE_LINKED_SELECT
        TYPE_DATE          = KayakoClient::CustomField::TYPE_DATE
        TYPE_FILE          = KayakoClient::CustomField::TYPE_FILE

        attr_accessor :ticket_id

        property :groups, [ :object ], :class => TicketCustomFieldGroup, :get => :group

        # NOTE: when a new field is added returns (for old tickets):
        # [Notice]: Undefined offset: 11 (api/class.Controller_TicketCustomField.php:279)

        def initialize(*args)
            properties = {}
            if args.last.is_a?(Hash)
                args.last.keys.each do |property|
                    if property.is_a?(String)
                        properties[property] = args.last.delete(property)
                    end
                end
                if args.last.has_key?(:ticket_id)
                    self.ticket_id = args.last.delete(:ticket_id)
                end
            end
            super
            if properties.size > 0
                properties.each do |property, value|
                    self[property] = value
                end
            end
        end

        def empty?
            if groups && groups.size > 0
                false
            elsif defined?(@new_group) && @new_group.size > 0
                false
            else
                true
            end
        end

        def custom_field(name)
            if defined?(@groups) && @groups.size > 0
                if name.is_a?(Numeric)
                    if name.to_i > 0
                        @groups.each do |group|
                            next unless group.fields && !group.fields.empty?
                            group.fields.each do |field|
                                if field.id == name.to_i
                                    return field.contents
                                end
                            end
                        end
                    end
                elsif name.is_a?(String)
                    @groups.each do |group|
                        next unless group.fields && !group.fields.empty?
                        group.fields.each do |field|
                            if field.title == name
                                return field.contents
                            end
                        end
                    end
                    @groups.each do |group|
                        next unless group.fields && !group.fields.empty?
                        group.fields.each do |field|
                            if field.name == name
                                return field.contents
                            end
                        end
                    end
                end
            end

            if defined?(@new_group) && @new_group.size > 0
                if name.is_a?(String)
                    @new_group.each do |field|
                        if field.name == name
                            return field.contents
                        end
                    end
                end
            end

            nil
        end

        def [](name)
            value = custom_field(name) unless name.is_a?(Symbol)
            value || super
        end

        def each(&block)
            if defined?(@groups) && @groups.size > 0
                @groups.each do |group|
                    group.fields.each(&block)
                end
            end

            if defined?(@new_group) && @new_group.size > 0
                @new_group.each(&block)
            end
        end

        def []=(name, value)
            if defined?(@groups) && @groups.size > 0
                if name.is_a?(Numeric)
                    if name.to_i > 0
                        @groups.each do |group|
                            next unless group.fields && !group.fields.empty?
                            group.fields.each do |field|
                                if field.id == name.to_i
                                    field.contents = value.to_s
                                    return field.contents
                                end
                            end
                        end
                        raise ArgumentError, "use custom field name"
                    else
                        raise ArgumentError, "invalid custom field ID"
                    end
                elsif name.is_a?(String)
                    @groups.each do |group|
                        next unless group.fields && !group.fields.empty?
                        group.fields.each do |field|
                            if field.title == name
                                field.contents = value.to_s
                                return field.contents
                            end
                        end
                    end
                    @groups.each do |group|
                        next unless group.fields && !group.fields.empty?
                        group.fields.each do |field|
                            if field.name == name
                                field.contents = value.to_s
                                return field.contents
                            end
                        end
                    end
                end
            end

            if name =~ %r{^[a-z0-9]{12}$}
                @new_group ||= []
                @new_group << TicketCustomFieldValue.new(:name => name.to_s, :contents => value.to_s)
                return value.to_s
            end

            super
        end

        def post
            raise RuntimeError, "client not configured" unless configured?
            raise RuntimeError, "missing ticket ID" unless ticket_id.to_i > 0
            params = {}
            each do |field|
                params[field.name] = field.contents
            end
            random = self.class.salt
            e = "#{self.class.path}/#{ticket_id.to_i}"
            response = client.post(api_url, params.merge(:e         => e,
                                                         :apikey    => api_key,
                                                         :salt      => random,
                                                         :signature => self.class.signature(random, secret_key)))
            if response.is_a?(KayakoClient::HTTPOK)
                if logger
                    logger.debug "Response:"
                    logger.debug response.body
                end
                payload = xml_backend.new(response.body, { :logger => logger })
                clean
                import(payload.to_hash)
                loaded!
                logger.info ":post successful" if logger
                true
            else
                unless response.is_a?(Hash)
                    logger.error "Response: #{response.status} #{response.body}" if logger
                    raise StandardError, "server returned #{response.status}: #{response.body}"
                end
                false
            end
        end

        def self.get(*args)
            object = super
            if object && object.respond_to?(:ticket_id=)
                object.ticket_id = args[0]
                object.loaded!
            end
            object
        end

    end

end
