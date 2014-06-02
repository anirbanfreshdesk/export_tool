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
    module KnowledgebaseCategoryClient

        def articles(options = {})
            KayakoClient::KnowledgebaseArticle.all(id, options.merge(inherited_options)) if id
        end

        def get_article(article, options = {})
            if id
                value = KayakoClient::KnowledgebaseArticle.get(article, options.merge(inherited_options))
                value && value.in_category?(id) ? value : nil
            end
        end

        alias_method :find_article, :get_article

        def post_article(options = {})
            if id
                if logger && options[:id] && options[:id].to_i != id
                    logger.warn "overwriting :id"
                end
                options[:id] = id
                KayakoClient::KnowledgebaseArticle.post(options.merge(inherited_options))
            end
        end

        alias_method :create_article, :post_article

        def delete_article(article, options = {})
            category_article = get_article(article, options.merge(inherited_options))
            category_article.delete if category_article
        end

        alias_method :destroy_article, :delete_article

    end
end
