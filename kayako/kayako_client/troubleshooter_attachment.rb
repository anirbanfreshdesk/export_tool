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

require 'kayako_client/mixins/troubleshooter_step_api'

require 'kayako_client/troubleshooter_step'

module KayakoClient
    class TroubleshooterAttachment < KayakoClient::Troubleshooter
        include KayakoClient::TroubleshooterStepAPI
        include KayakoClient::Attachment

        path '/Troubleshooter/Attachment'

        supports :all, :get, :post, :delete

        property :id,                     :integer, :readonly => true
        property :troubleshooter_step_id, :integer, :required => :post
        property :file_name,              :string,  :required => :post
        property :file_size,              :integer, :readonly => true
        property :file_type,              :string,  :readonly => true
        property :date_line,              :date,    :readonly => true
        property :contents,               :binary,  :required => :post, :new => true
        property :link,                   :string,  :readonly => true

        associate :troubleshooter_step,   :troubleshooter_step_id, TroubleshooterStep

        if method_defined?(:contents)
            remove_method(:contents)
        end

        def contents
            if instance_variable_defined?(:@contents)
                instance_variable_get(:@contents)
            else
                if !new? && id && id > 0
                    if troubleshooter_step_id.nil? && !link.nil? && link.match(%r{/[0-9]+/([0-9]+)/([0-9]+)/?$}) && $2.to_i == id
                        troubleshooter_step_id = $1.to_i
                    end
                    if troubleshooter_step_id && troubleshooter_step_id > 0
                        logger.debug "contents are missing - trying to reload" if logger
                        if reload!(:e => "#{self.class.path}/#{troubleshooter_step_id.to_i}/#{id.to_i}") && instance_variable_defined?(:@contents)
                            instance_variable_get(:@contents)
                        else
                            instance_variable_set(:@contents, nil)
                        end
                    else
                        nil
                    end
                else
                    nil
                end
            end
        end

    end
end
