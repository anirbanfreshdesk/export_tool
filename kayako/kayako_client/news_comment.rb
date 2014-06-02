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
require 'kayako_client/mixins/comment_object'

require 'kayako_client/news_item'

module KayakoClient
    class NewsComment < KayakoClient::News
        include KayakoClient::CreatorAPI
        include KayakoClient::CommentObject

        path '/News/Comment'

        property :news_item_id, :integer, :required => :post

        associate :news_item, :news_item_id, NewsItem

    end
end
