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

require 'kayako_client/staff'
require 'kayako_client/user_group'
require 'kayako_client/staff_group'

module KayakoClient
    class KnowledgebaseCategory < KayakoClient::Knowledgebase
        include KayakoClient::ConvertAPI
        include KayakoClient::UserVisibilityAPI
        include KayakoClient::StaffVisibilityAPI
        include KayakoClient::KnowledgebaseCategoryClient

        path '/Knowledgebase/Category'

        TYPE_GLOBAL  = 1
        TYPE_PUBLIC  = 2
        TYPE_PRIVATE = 3
        TYPE_INHERIT = 4

        SORT_INHERIT      = 1
        SORT_TITLE        = 2
        SORT_RATING       = 3
        SORT_CREATIONDATE = 4
        SORT_DISPLAYORDER = 5

        property :id,                      :integer, :readonly => true
        property :parent_kb_category_id,   :integer
        property :staff_id,                :integer, :new => true
        property :title,                   :string,  :required => [ :put, :post ]
        property :total_articles,          :integer, :readonly => true
        property :category_type,           :integer, :required => :post, :range => 1..4
        property :display_order,           :integer
        property :allow_comments,          :boolean
        property :allow_rating,            :boolean
        property :is_published,            :boolean
        property :article_sort_order,      :integer, :range => 1..5
        property :user_visibility_custom,  :boolean
        property :user_group_ids,        [ :integer ], :get => :usergroupidlist, :set => :usergroupidlist, :condition => { :user_visibility_custom => true }
        property :staff_visibility_custom, :boolean
        property :staff_group_ids,       [ :integer ], :get => :staffgroupidlist, :set => :staffgroupidlist, :condition => { :staff_visibility_custom => true }

        associate :parent_category,        :parent_kb_category_id, KnowledgebaseCategory
        associate :staff,                  :staff_id,              Staff
        associate :user_groups,            :user_group_ids,        UserGroup
        associate :staff_groups,           :staff_group_ids,       StaffGroup

        def has_parent_category?
            !parent_kb_category_id.nil? && parent_kb_category_id > 0
        end

        def parent_is_root?
            !parent_kb_category_id.nil? && parent_kb_category_id == 0
        end

        def self.all(*args)
            e = path + '/ListAll'
            options = args.last.is_a?(Hash) ? args.pop : {}
            if args.size > 0
                if args.size <= 2
                    e << '/' + args.collect { |arg| arg.to_i }.join('/')
                else
                    raise ArgumentError, "too many arguments"
                end
            end
            super(options.merge(:e => e))
        end

    end
end
