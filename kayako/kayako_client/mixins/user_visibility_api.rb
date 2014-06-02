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
    module UserVisibilityAPI

        def visible_to_user_group?(group)
            !user_visibility_custom || (!user_group_ids.nil? && user_group_ids.include?(group.to_i))
        end

    end
end
