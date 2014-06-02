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
    module TroubleshooterStepClient

        def get_attachment(attachment, options = {})
            KayakoClient::TroubleshooterAttachment.get(id, attachment, options.merge(inherited_options)) if id
        end

        alias_method :find_attachment, :get_attachment

        def post_attachment(options = {})
            if id
                if logger && options[:troubleshooter_step_id] && options[:troubleshooter_step_id].to_i != id
                    logger.warn "overwriting :troubleshooter_step_id"
                end
                options[:troubleshooter_step_id] = id
                KayakoClient::TroubleshooterAttachment.post(options.merge(inherited_options))
            end
        end

        alias_method :create_attachment, :post_attachment

        def delete_attachment(attachment, options = {})
            KayakoClient::TroubleshooterAttachment.delete(id, attachment, options.merge(inherited_options)) if id
        end

        alias_method :destroy_attachment, :delete_attachment


        def comments(options = {})
            KayakoClient::TroubleshooterComment.all(id, options.merge(inherited_options)) if id
        end

        def get_comment(comment, options = {})
            if id
                value = KayakoClient::TroubleshooterComment.get(comment, options.merge(inherited_options))
                value && value.troubleshooter_step_id == id ? value : nil
            end
        end

        alias_method :find_comment, :get_comment

        def post_comment(options = {})
            if id
                if logger && options[:troubleshooter_step_id] && options[:troubleshooter_step_id].to_i != id
                    logger.warn "overwriting :troubleshooter_step_id"
                end
                options[:troubleshooter_step_id] = id
                KayakoClient::TroubleshooterComment.post(options.merge(inherited_options))
            end
        end

        alias_method :create_comment, :post_comment

        def delete_comment(comment, options = {})
            step_comment = get_comment(comment, options.merge(inherited_options))
            step_comment.delete if step_comment
        end

        alias_method :destroy_comment, :delete_comment

    end
end
