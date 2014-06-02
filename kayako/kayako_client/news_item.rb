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

require 'kayako_client/mixins/convert_api'

require 'kayako_client/news_category'

require 'kayako_client/staff'

module KayakoClient
    class NewsItem < KayakoClient::News
        include KayakoClient::ConvertAPI
        include KayakoClient::NewsClient
        include KayakoClient::UserVisibilityAPI
        include KayakoClient::StaffVisibilityAPI

        TYPE_GLOBAL  = 1
        TYPE_PUBLIC  = 2
        TYPE_PRIVATE = 3

        STATUS_DRAFT     = 1
        STATUS_PUBLISHED = 2

        property :id,                      :integer, :readonly => true
        property :staff_id,                :integer, :required => :post
        property :news_type,               :integer, :range => 1..3, :new => true
        property :news_status,             :integer, :range => 1..2
        property :author,                  :string,  :readonly => true
        property :email,                   :string
        property :subject,                 :string, :required => [ :put, :post ]
        property :date_line,               :date,   :readonly => true
        property :expiry,                  :date
        property :is_synced,               :boolean, :readonly => true
        property :total_comments,          :integer, :readonly => true
        property :user_visibility_custom,  :boolean
        property :user_group_ids,        [ :integer ], :get => :usergroupidlist, :set => :usergroupidlist, :condition => { :user_visibility_custom => true }
        property :staff_visibility_custom, :boolean
        property :staff_group_ids,       [ :integer ], :get => :staffgroupidlist, :set => :staffgroupidlist, :condition => { :staff_visibility_custom => true }
        property :allow_comments,          :boolean
        property :contents,                :string, :required => [ :put, :post ]
        property :category_ids,          [ :integer ], :get => :categories, :set => :newscategoryidlist
        property :from_name,               :string
        property :custom_email_subject,    :string
        property :send_email,              :boolean
        property :edited_staff_id,         :integer, :required => :put

        associate :staff,                  :staff_id,        Staff
        associate :user_groups,            :user_group_ids,  UserGroup
        associate :staff_groups,           :staff_group_ids, StaffGroup
        associate :categories,             :category_ids,    NewsCategory
        associate :edited_staff,           :edited_staff_id, Staff

        def in_category?(category)
            category.respond_to?(:to_i) && !category_ids.nil? && category_ids.include?(category.to_i)
        end

        def self.all(*args)
            options = args.last.is_a?(Hash) ? args.pop : {}
            if args.size > 0
                if args.size == 1
                    options.merge!(:e => "#{path}/ListAll/#{args.first.to_i}")
                else
                    raise ArgumentError, "too many arguments"
                end
            end
            super(options)
        end

    end
end
