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
    module NewsCategoryClient

        def news(options = {})
            KayakoClient::NewsItem.all(id, options.merge(inherited_options)) if id
        end

        def get_news(news, options = {})
            if id
                value = KayakoClient::NewsItem.get(news, options.merge(inherited_options))
                value && value.in_category?(id) ? value : nil
            end
        end

        alias_method :find_news, :get_news

        def post_news(options = {})
            if id
                if logger && options[:id] && options[:id].to_i != id
                    logger.warn "overwriting :id"
                end
                options[:id] = id
                KayakoClient::NewsItem.post(options.merge(inherited_options))
            end
        end

        alias_method :create_news, :post_news

        def delete_news(news, options = {})
            category_news = get_news(news, options.merge(inherited_options))
            category_news.delete if category_news
        end

        alias_method :destroy_news, :delete_news

    end
end
