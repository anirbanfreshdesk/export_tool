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

require 'kayako_client/mixins/creator_api'

require 'kayako_client/staff'
require 'kayako_client/user'

module KayakoClient
    module CommentObject

        CREATOR_STAFF = 1
        CREATOR_USER  = 2

        STATUS_PENDING  = 1
        STATUS_APPROVED = 2
        STATUS_SPAM     = 3

        def self.included(base)
            base.extend(ClassMethods)
            base.class_eval do

                supports :all, :get, :post, :delete

                property :id,                :integer, :readonly => true
                property :creator_type,      :integer, :required => :post, :range => 1..2
                property :creator_id,        :integer
                property :full_name,         :string
                property :email,             :string
                property :ip_address,        :string,  :readonly => true
                property :date_line,         :date,    :readonly => true
                property :parent_comment_id, :integer
                property :comment_status,    :integer, :range => 1..3
                property :user_agent,        :string,  :readonly => true
                property :referrer,          :string,  :readonly => true
                property :parent_url,        :string,  :readonly => true
                property :contents,          :string,  :required => :post

                associate :parent_comment,   :parent_comment_id, base

            end
        end

        def creator=(creator)
            if creator.is_a?(Staff)
                self.creator_type = self.class::CREATOR_STAFF
                self.creator_id = creator.id
                self.full_name = creator.full_name
                self.email = creator.email
            elsif creator.is_a?(User)
                self.creator_type = self.class::CREATOR_USER
                self.creator_id = creator.id
                self.full_name = creator.full_name
                self.email = creator.emails.first
            else
                raise ArgumentError, "creator must be a User or Staff"
            end
        end

        def has_parent_comment?
            !parent_comment_id.nil? && parent_comment_id > 0
        end

        alias_method :is_reply?, :has_parent_comment?

        module ClassMethods

            def all(object, options = {})
                unless object.to_i > 0
                    logger.error "invalid commented object :id - #{object}" if logger
                    raise ArgumentError, "invalid commented object ID"
                end
                super(options.merge(:e => "#{path}/ListAll/#{object.to_i}"))
            end

        end

    private

        def validate(method, params)
            if method == :post
                if params[:creator_type] == self.class::CREATOR_STAFF
                    raise ArgumentError, ":creator_id is required for staff" unless params[:creator_id]
                elsif params[:creator_type] == self.class::CREATOR_USER
                    raise ArgumentError, ":full_name is required for user" unless params[:full_name]
                end
            end
        end

    end
end
