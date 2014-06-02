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
    class NewsCategory < KayakoClient::News
        include KayakoClient::NewsCategoryClient

        path '/News/Category'

        VISIBILITY_TYPES = [ :public, :private ].freeze

        property :id,              :integer, :readonly => true
        property :title,           :string,  :required => [ :put, :post ]
        property :news_item_count, :integer, :readonly => true
        property :visibility_type, :symbol,  :required => [ :put, :post ], :in => VISIBILITY_TYPES

    end
end
