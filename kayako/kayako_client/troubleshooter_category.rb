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

require 'kayako_client/mixins/convert_api'

require 'kayako_client/staff'
require 'kayako_client/user_group'
require 'kayako_client/staff_group'

module KayakoClient
    class TroubleshooterCategory < KayakoClient::Troubleshooter
        include KayakoClient::ConvertAPI
        include KayakoClient::UserVisibilityAPI
        include KayakoClient::StaffVisibilityAPI

        path '/Troubleshooter/Category'

        TYPE_GLOBAL  = 1
        TYPE_PUBLIC  = 2
        TYPE_PRIVATE = 3

        property :id,                      :integer, :readonly => true
        property :staff_id,                :integer, :required => :post, :new => true
        property :staff_name,              :string,  :readonly => true
        property :title,                   :string,  :required => :post
        property :description,             :string
        property :category_type,           :integer, :required => :post, :range => 1..3
        property :display_order,           :integer
        property :views,                   :integer, :readonly => true
        property :user_visibility_custom,  :boolean
        property :user_group_ids,        [ :integer ], :get => :usergroupidlist, :set => :usergroupidlist, :condition => { :user_visibility_custom => true }
        property :staff_visibility_custom, :boolean
        property :staff_group_ids,       [ :integer ], :get => :staffgroupidlist, :set => :staffgroupidlist, :condition => { :staff_visibility_custom => true }

        associate :staff,                  :staff_id,        Staff
        associate :user_groups,            :user_group_ids,  UserGroup
        associate :staff_groups,           :staff_group_ids, StaffGroup

    end
end
