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

require 'kayako_client/user'
require 'kayako_client/user_group'

module KayakoClient
    class NewsSubscriber < KayakoClient::News
        path '/News/Subscriber'

        property :id,                :integer, :readonly => true
        property :template_group_id, :integer, :readonly => true, :get => :tgroupid
        property :user_id,           :integer, :readonly => true
        property :email,             :string,  :required => [ :put, :post ]
        property :is_validated,      :boolean, :new => true
        property :user_group_id,     :integer, :readonly => true

        associate :user,             :user_id,       User
        associate :user_group,       :user_group_id, UserGroup

    end
end
