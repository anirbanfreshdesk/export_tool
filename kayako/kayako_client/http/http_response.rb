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

    class HTTPResponse
        attr_accessor :status, :body

        def initialize(status, body = '')
            @status = status
            @body = body
        end

    end

    class HTTPOK < HTTPResponse

        def initialize(body = '')
            super(200, body)
        end

    end

    class HTTPBadRequest < HTTPResponse

        def initialize(body = '')
            super(400, body)
        end

    end

    class HTTPUnauthorized < HTTPResponse

        def initialize(body = '')
            super(401, body)
        end

    end

    class HTTPForbidden < HTTPResponse

        def initialize(body = '')
            super(403, body)
        end

    end

    class HTTPNotFound < HTTPResponse

        def initialize(body = '')
            super(404, body)
        end

    end

    class HTTPNotAllowed < HTTPResponse

        def initialize(body = '')
            super(405, body)
        end

    end

end
