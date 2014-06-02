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

require 'kayako_client/http/http_response'
require 'kayako_client/http/http_backend'
require 'kayako_client/http/http'

require 'kayako_client/xml/xml_backend'
require 'kayako_client/xml/xml'

require 'kayako_client/mixins/api'
require 'kayako_client/mixins/object'
require 'kayako_client/mixins/client'
require 'kayako_client/mixins/ticket_client'
require 'kayako_client/mixins/post_client'
require 'kayako_client/mixins/article_client'
require 'kayako_client/mixins/knowledgebase_category_client'
require 'kayako_client/mixins/news_category_client'
require 'kayako_client/mixins/news_client'
require 'kayako_client/mixins/troubleshooter_step_client'
require 'kayako_client/mixins/logger'
require 'kayako_client/mixins/authentication'
require 'kayako_client/mixins/attachment'
require 'kayako_client/mixins/ticket_api'
require 'kayako_client/mixins/user_visibility_api'
require 'kayako_client/mixins/staff_visibility_api'

require 'kayako_client/base'
require 'kayako_client/custom_field'
require 'kayako_client/department'
require 'kayako_client/knowledgebase_article'
require 'kayako_client/knowledgebase_attachment'
require 'kayako_client/knowledgebase_category'
require 'kayako_client/knowledgebase_comment'
require 'kayako_client/news_category'
require 'kayako_client/news_comment'
require 'kayako_client/news_item'
require 'kayako_client/news_subscriber'
require 'kayako_client/staff'
require 'kayako_client/staff_group'
require 'kayako_client/ticket'
require 'kayako_client/ticket_attachment'
require 'kayako_client/ticket_custom_field'
require 'kayako_client/ticket_note'
require 'kayako_client/ticket_post'
require 'kayako_client/ticket_priority'
require 'kayako_client/ticket_status'
require 'kayako_client/ticket_time_track'
require 'kayako_client/ticket_type'
require 'kayako_client/ticket_count'
require 'kayako_client/troubleshooter_attachment'
require 'kayako_client/troubleshooter_category'
require 'kayako_client/troubleshooter_comment'
require 'kayako_client/troubleshooter_step'
require 'kayako_client/user'
require 'kayako_client/user_group'
require 'kayako_client/user_organization'
