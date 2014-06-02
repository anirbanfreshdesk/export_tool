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

require 'kayako_client/mixins/user_visibility_api'

module KayakoClient
    class TicketPriority < KayakoClient::Tickets
        include KayakoClient::UserVisibilityAPI

        supports :all, :get

        PRIORITY_TYPES = [ :public, :private ].freeze

        property :id,                     :integer
        property :title,                  :string
        property :display_order,          :integer
        property :fr_color_code,          :string
        property :bg_color_code,          :string
        property :display_icon,           :string
        property :type,                   :symbol, :in => PRIORITY_TYPES
        property :user_visibility_custom, :boolean
        property :user_group_ids,       [ :integer ], :get => :usergroupid, :condition => { :user_visibility_custom => true }

        associate :user_groups,           :user_group_ids, UserGroup

    end
end
