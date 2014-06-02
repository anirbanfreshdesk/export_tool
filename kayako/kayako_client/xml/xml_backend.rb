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

    module XMLBackend

        def initialize(document)
            raise NotImplementedError, "not implemented"
        end

        def count
            raise NotImplementedError, "not implemented"
        end

        def each(&block)
            raise NotImplementedError, "not implemented"
        end

        def to_hash(root = nil)
            raise NotImplementedError, "not implemented"
        end

        def notice?
            defined?(@notice)
        end

        def error?
            defined?(@error)
        end

        def notice
            @notice || nil
        end

        def error
            @error || nil
        end

    end

    module XMLException
    end

end
