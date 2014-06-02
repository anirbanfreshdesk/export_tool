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
    module NewsClient

        def comments(options = {})
            KayakoClient::NewsComment.all(id, options.merge(inherited_options)) if id
        end

        def get_comment(comment, options = {})
            if id
                value = KayakoClient::NewsComment.get(comment, options.merge(inherited_options))
                value && value.news_item_id == id ? value : nil
            end
        end

        alias_method :find_comment, :get_comment

        def post_comment(options = {})
            if id
                if logger && options[:news_item_id] && options[:news_item_id].to_i != id
                    logger.warn "overwriting :news_item_id"
                end
                options[:news_item_id] = id
                KayakoClient::NewsComment.post(options.merge(inherited_options))
            end
        end

        alias_method :create_comment, :post_comment

        def delete_comment(comment, options = {})
            news_comment = get_comment(comment, options.merge(inherited_options))
            news_comment.delete if news_comment
        end

        alias_method :destroy_comment, :delete_comment

    end
end
