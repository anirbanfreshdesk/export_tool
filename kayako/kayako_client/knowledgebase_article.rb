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
require 'kayako_client/mixins/creator_api'

require 'kayako_client/knowledgebase_category'

require 'kayako_client/staff'
require 'kayako_client/user'

module KayakoClient

    class KnowledgebaseAttachment < KayakoClient::Knowledgebase
    end

    class KnowledgebaseArticle < KayakoClient::Knowledgebase
        include KayakoClient::ConvertAPI
        include KayakoClient::CreatorAPI
        include KayakoClient::ArticleClient

        path '/Knowledgebase/Article'

        CREATOR_USER  = 1
        CREATOR_STAFF = 2

        STATUS_PUBLISHED       = 1
        STATUS_DRAFT           = 2
        STATUS_PENDINGAPPROVAL = 3

        property :kb_article_id,    :integer, :readonly => true
        property :contents,         :string,  :required => [ :put, :post ]
        property :contents_text,    :string,  :readonly => true
        property :category_ids,   [ :integer ], :get => :categories, :set => :categoryid
        property :creator_type,     :integer, :readonly => true, :get => :creator, :range => 1..2
        property :creator_id,       :integer, :required => :post
        property :is_edited,        :boolean, :readonly => true
        property :subject,          :string,  :required => [ :put, :post ]
        property :edited_date_line, :date,    :readonly => true
        property :edited_staff_id,  :integer, :required => :put
        property :views,            :integer, :readonly => true
        property :is_featured,      :boolean
        property :allow_comments,   :boolean
        property :total_comments,   :integer, :readonly => true
        property :has_attachments,  :boolean, :readonly => true
        property :date_line,        :date,    :readonly => true
        property :article_status,   :integer, :range => 1..3
        property :article_rating,   :float,   :readonly => true
        property :rating_hits,      :integer, :readonly => true
        property :rating_count,     :integer, :readonly => true

        property :attachments,    [ :object ], :class => KnowledgebaseAttachment

        associate :categories,      :category_ids,    KnowledgebaseCategory
        associate :edited_staff,    :edited_staff_id, Staff

        alias_method :id, :kb_article_id

        def in_root_category?
            !category_ids.nil? && category_ids.include?(0)
        end

        def in_category?(category)
            category.respond_to?(:to_i) && !category_ids.nil? && category_ids.include?(category.to_i)
        end

        if method_defined?(:categories)
            remove_method(:categories)
        end

        def categories
            if @associated.has_key?(:category_ids)
                @associated[:category_ids]
            elsif instance_variable_defined?(:@category_ids)
                category_ids = instance_variable_get(:@category_ids)
                if category_ids.is_a?(Array)
                    @associated[:category_ids] = category_ids.inject([]) do |array, i|
                        array << KnowledgebaseCategory.get(i.to_i, inherited_options) unless i.to_i == 0
                        array
                    end
                else
                    @associated[:category_ids] = nil
                end
            else
                @associated[:category_ids] = nil
            end
        end

        def self.all(*args)
            options = args.last.is_a?(Hash) ? args.pop : {}
            if args.size > 0
                if args.size <= 3
                    e = path + '/ListAll/' + args.collect { |arg| arg.to_i }.join('/')
                    options.merge!(:e => e)
                else
                    raise ArgumentError, "too many arguments"
                end
            end
            super(options)
        end

    private

        def validate(method, params)
            if method == :put
                unless changes.include?(:edited_staff_id) && params[:edited_staff_id].to_i > 0
                    raise ArgumentError, ":edited_staff_id is required"
                end
            end
        end

        def assign_value(type, value, options = {})
            if type == :object && value.is_a?(Hash) && options[:class] == KnowledgebaseAttachment
                value[:kb_article_id] = kb_article_id unless value.has_key?(:kbarticleid)
            end
            super(type, value, options)
        end

    end

end
