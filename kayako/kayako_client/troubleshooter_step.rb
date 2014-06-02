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

require 'kayako_client/mixins/convert_api'

require 'kayako_client/troubleshooter_category'

require 'kayako_client/staff'
require 'kayako_client/department'
require 'kayako_client/ticket_type'
require 'kayako_client/ticket_priority'

module KayakoClient

    class TroubleshooterAttachment < KayakoClient::Troubleshooter
    end

    class TroubleshooterStep < KayakoClient::Troubleshooter
        include KayakoClient::ConvertAPI
        include KayakoClient::TroubleshooterStepClient

        path '/Troubleshooter/Step'

        STATUS_PUBLISHED = 1
        STATUS_DRAFT     = 2

        property :id,                        :integer, :readonly => true
        property :category_id,               :integer, :required => :post, :new => true
        property :staff_id,                  :integer, :required => :post, :new => true
        property :staff_name,                :string,  :readonly => true
        property :subject,                   :string,  :required => :post
        property :edited,                    :boolean, :readonly => true
        property :edited_staff_id,           :integer, :required => :put
        property :edited_staff_name,         :string,  :readonly => true
        property :display_order,             :integer
        property :views,                     :integer, :readonly => true
        property :allow_comments,            :boolean
        property :has_attachments,           :boolean, :readonly => true
        property :parent_step_ids,         [ :integer ], :get => :parentsteps, :set => :parentstepidlist
        property :child_step_ids,          [ :integer ], :readonly => true, :get => :childsteps
        property :redirect_tickets,          :boolean, :readonly => true
        property :ticket_subject,            :string
        property :redirect_department_id,    :integer
        property :ticket_type_id,            :integer
        property :ticket_priority_id,        :integer, :get => :priorityid
        property :contents,                  :string, :required => :post
        property :enable_ticket_redirection, :boolean
        property :step_status,               :integer, :range => 1..2

        property :attachments,             [ :object ], :class => TroubleshooterAttachment

        associate :category,                 :category_id,            TroubleshooterCategory
        associate :staff,                    :staff_id,               Staff
        associate :edited_staff,             :edited_staff_id,        Staff
        associate :parent_steps,             :parent_step_ids,        TroubleshooterStep
        associate :child_steps,              :child_step_ids,         TroubleshooterStep
        associate :redirect_department,      :redirect_department_id, Department
        associate :ticket_type,              :ticket_type_id,         TicketType
        associate :priority,                 :ticket_priority_id,     TicketPriority

        def has_parent_steps?
            !parent_step_ids.nil? && parent_step_ids.size > 0
        end

        def has_child_steps?
            !child_step_ids.nil? && child_step_ids.size > 0
        end

        def in_step?(step)
            step.respond_to?(:to_i) && !parent_step_ids.nil? && parent_step_ids.include?(step.to_i)
        end

        def has_step?(step)
            step.respond_to?(:to_i) && !child_step_ids.nil? && child_step_ids.include?(step.to_i)
        end

    private

        def validate(method, params)
            if method == :put
                unless changes.include?(:edited_staff_id) && params[:edited_staff_id].to_i > 0
                    raise ArgumentError, ":edited_staff_id is required"
                end
            end
        end

    end

end
