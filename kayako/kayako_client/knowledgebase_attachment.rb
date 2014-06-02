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

require 'kayako_client/mixins/knowledgebase_article_api'

require 'kayako_client/knowledgebase_article'

module KayakoClient
    class KnowledgebaseAttachment < KayakoClient::Knowledgebase
        include KayakoClient::KnowledgebaseArticleAPI
        include KayakoClient::Attachment

        path '/Knowledgebase/Attachment'

        supports :all, :get, :post, :delete

        property :id,            :integer, :readonly => true
        property :kb_article_id, :integer, :required => :post
        property :file_name,     :string, :required => :post
        property :file_size,     :integer, :readonly => true
        property :file_type,     :string, :readonly => true
        property :date_line,     :date, :readonly => true
        property :contents,      :binary, :required => :post, :new => true
        property :link,          :string, :readonly => true

        associate :article,      :kb_article_id, KnowledgebaseArticle

        if method_defined?(:contents)
            remove_method(:contents)
        end

        def contents
            if instance_variable_defined?(:@contents)
                instance_variable_get(:@contents)
            elsif !new? && id && kb_article_id && id > 0 && kb_article_id > 0
                logger.debug "contents are missing - trying to reload" if logger
                if reload!(:e => "#{self.class.path}/#{kb_article_id.to_i}/#{id.to_i}") && instance_variable_defined?(:@contents)
                    instance_variable_get(:@contents)
                else
                    instance_variable_set(:@contents, nil)
                end
            else
                nil
            end
        end

    end
end
