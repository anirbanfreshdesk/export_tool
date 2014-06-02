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

module KayakoClient
    module ArticleClient

        def get_attachment(attachment, options = {})
            KayakoClient::KnowledgebaseAttachment.get(kb_article_id, attachment, options.merge(inherited_options)) if kb_article_id
        end

        alias_method :find_attachment, :get_attachment

        def post_attachment(options = {})
            if kb_article_id
                if logger && options[:kb_article_id] && options[:kb_article_id].to_i != kb_article_id
                    logger.warn "overwriting :kb_article_id"
                end
                options[:kb_article_id] = kb_article_id
                KayakoClient::KnowledgebaseAttachment.post(options.merge(inherited_options))
            end
        end

        alias_method :create_attachment, :post_attachment

        def delete_attachment(attachment, options = {})
            KayakoClient::KnowledgebaseAttachment.delete(kb_article_id, attachment, options.merge(inherited_options)) if kb_article_id
        end

        alias_method :destroy_attachment, :delete_attachment


        def comments(options = {})
            KayakoClient::KnowledgebaseComment.all(kb_article_id, options.merge(inherited_options)) if kb_article_id
        end

        def get_comment(comment, options = {})
            if kb_article_id
                value = KayakoClient::KnowledgebaseComment.get(comment, options.merge(inherited_options))
                value && value.kb_article_id == kb_article_id ? value : nil
            end
        end

        alias_method :find_comment, :get_comment

        def post_comment(options = {})
            if kb_article_id
                if logger && options[:kb_article_id] && options[:kb_article_id].to_i != kb_article_id
                    logger.warn "overwriting :kb_article_id"
                end
                options[:kb_article_id] = kb_article_id
                KayakoClient::KnowledgebaseComment.post(options.merge(inherited_options))
            end
        end

        alias_method :create_comment, :post_comment

        def delete_comment(comment, options = {})
            article_comment = get_comment(comment, options.merge(inherited_options))
            article_comment.delete if article_comment
        end

        alias_method :destroy_comment, :delete_comment

    end
end
