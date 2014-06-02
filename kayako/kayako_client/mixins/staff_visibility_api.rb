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
    module StaffVisibilityAPI

        def visible_to_staff_group?(group)
            !staff_visibility_custom || (!staff_group_ids.nil? && staff_group_ids.include?(group.to_i))
        end

    end
end
