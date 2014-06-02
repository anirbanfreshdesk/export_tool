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
    module TroubleshooterStepAPI

        def self.included(base)
            base.extend(ClassMethods)
        end

        def delete_request(options = {})
            raise RuntimeError, "undefined troubleshooter step ID" unless troubleshooter_step_id
            raise RuntimeError, "undefined ID" unless id
            super(options.merge(:e => "#{self.class.path}/#{troubleshooter_step_id}/#{id}"))
        end

        module ClassMethods

            def all(step, options = {})
                unless step.to_i > 0
                    logger.error "invalid :troubleshooter_step_id - #{step}" if logger
                    raise ArgumentError, "invalid troubleshooter step ID"
                end
                super(options.merge(:e => "#{path}/ListAll/#{step.to_i}"))
            end

            def get(step, id, options = {})
                unless step.to_i > 0
                    logger.error "invalid :troubleshooter_step_id - #{step}" if logger
                    raise ArgumentError, "invalid troubleshooter step ID"
                end
                if id == :all
                    all(step, options)
                else
                    unless id.to_i > 0
                        logger.error "invalid :id - #{id}" if logger
                        raise ArgumentError, "invalid ID"
                    end
                    super(id, options.merge(:e => "#{path}/#{step.to_i}/#{id.to_i}"))
                end
            end

            def delete(step, id, options = {})
                unless step.to_i > 0
                    logger.error "invalid :troubleshooter_step_id - #{step}" if logger
                    raise ArgumentError, "invalid troubleshooter step ID"
                end
                unless id.to_i > 0
                    logger.error "invalid :id - #{id}" if logger
                    raise ArgumentError, "invalid ID"
                end
                super(id, options.merge(:e => "#{path}/#{step.to_i}/#{id.to_i}"))
            end

        end

    end
end
