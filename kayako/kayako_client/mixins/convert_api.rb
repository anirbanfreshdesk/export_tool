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
    module ConvertAPI

        def self.included(base)
            base.extend(ClassMethods)
        end

        module ClassMethods

            def convert(type, value, options = {})
                value = super(type, value, options)
                value = value.join(',') if type.is_a?(Array)
                value
            end

            def convert_value(type, value, options = {})
                result = super(type, value, options = {})
                result = Time.at(value).strftime('%m/%d/%Y') if type == :date
                result
            end

        end

    end
end
