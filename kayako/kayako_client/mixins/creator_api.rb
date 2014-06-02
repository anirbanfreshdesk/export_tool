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
    module CreatorAPI

        def created_by_staff?
            !creator_type.nil? && creator_type == self.class::CREATOR_STAFF
        end

        def created_by_user?
            !creator_type.nil? && creator_type == self.class::CREATOR_USER
        end

        def creator
            if @associated.has_key?(:creator)
                @associated[:creator]
            elsif instance_variable_defined?(:@creator_id)
                creator_id = instance_variable_get(:@creator_id)
                if created_by_staff?
                    @associated[:creator] = Staff.get(creator_id.to_i, inherited_options)
                elsif created_by_user?
                    @associated[:creator] = User.get(creator_id.to_i, inherited_options)
                else
                    @associated[:creator] = nil
                end
            else
                @associated[:creator] = nil
            end
        end

    end
end
