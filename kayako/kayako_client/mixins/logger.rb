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
    module Logger

        def self.included(base)
            base.extend(ClassMethods)
        end

        def logger=(log)
            @logger = log
        end

        def logger
            @logger ||= self.class.logger
        end

        module ClassMethods

            def logger=(log)
                @@logger = log
            end

            def logger
                @@logger ||= nil
            end

        end

    end
end
