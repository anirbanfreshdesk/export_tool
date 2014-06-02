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
    class UserGroup < KayakoClient::Base

        USER_GROUP_TYPES = [ :guest, :registered ].freeze

        property :id,         :integer, :readonly => true
        property :title,      :string, :required => [ :put, :post ]
        property :group_type, :symbol, :required => :post, :new => true
        property :is_master,  :boolean, :readonly => true

    end
end
