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

require 'kayako_client/knowledgebase_article'

module KayakoClient
    class KnowledgebaseComment < KayakoClient::Knowledgebase
        include KayakoClient::CreatorAPI
        include KayakoClient::CommentObject

        path '/Knowledgebase/Comment'

        property :kb_article_id, :integer, :required => :post, :set => :knowledgebasearticleid

        associate :article, :kb_article_id, KnowledgebaseArticle

    end
end
