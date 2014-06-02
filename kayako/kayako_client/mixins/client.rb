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
    module Client

        def departments(options = {})
            KayakoClient::Department.all(options.merge(inherited_options))
        end

        def get_department(id = :all, options = {})
            KayakoClient::Department.get(id, options.merge(inherited_options))
        end

        alias_method :find_department, :get_department

        def post_department(options = {})
            KayakoClient::Department.post(options.merge(inherited_options))
        end

        alias_method :create_department, :post_department

        def delete_department(id, options = {})
            KayakoClient::Department.delete(id, options.merge(inherited_options))
        end

        alias_method :destroy_department, :delete_department


        def knowledgebase_articles(*args)
            options = args.last.is_a?(Hash) ? args.pop : {}
            args << options.merge(inherited_options)
            KayakoClient::KnowledgebaseArticle.all(*args)
        end

        def get_knowledgebase_article(id = :all, options = {})
            KayakoClient::KnowledgebaseArticle.get(id, options.merge(inherited_options))
        end

        alias_method :find_knowledgebase_article, :get_knowledgebase_article

        def post_knowledgebase_article(options = {})
            KayakoClient::KnowledgebaseArticle.post(options.merge(inherited_options))
        end

        alias_method :create_knowledgebase_article, :post_knowledgebase_article

        def delete_knowledgebase_article(id, options = {})
            KayakoClient::KnowledgebaseArticle.delete(id, options.merge(inherited_options))
        end

        alias_method :destroy_knowledgebase_article, :delete_knowledgebase_article


        def knowledgebase_attachments(article, options = {})
            KayakoClient::KnowledgebaseAttachment.all(article, options.merge(inherited_options))
        end

        def get_knowledgebase_attachment(article, id, options = {})
            KayakoClient::KnowledgebaseAttachment.get(article, id, options.merge(inherited_options))
        end

        alias_method :find_knowledgebase_attachment, :get_knowledgebase_attachment

        def post_knowledgebase_attachment(options = {})
            KayakoClient::KnowledgebaseAttachment.post(options.merge(inherited_options))
        end

        alias_method :create_knowledgebase_attachment, :post_knowledgebase_attachment

        def delete_knowledgebase_attachment(article, id, options = {})
            KayakoClient::KnowledgebaseAttachment.delete(article, id, options.merge(inherited_options))
        end

        alias_method :destroy_knowledgebase_attachment, :delete_knowledgebase_attachment


        def knowledgebase_categories(options = {})
            KayakoClient::KnowledgebaseCategory.all(options.merge(inherited_options))
        end

        def get_knowledgebase_category(id = :all, options = {})
            KayakoClient::KnowledgebaseCategory.get(id, options.merge(inherited_options))
        end

        alias_method :find_knowledgebase_category, :get_knowledgebase_category

        def post_knowledgebase_category(options = {})
            KayakoClient::KnowledgebaseCategory.post(options.merge(inherited_options))
        end

        alias_method :create_knowledgebase_category, :post_knowledgebase_category

        def delete_knowledgebase_category(id, options = {})
            KayakoClient::KnowledgebaseCategory.delete(id, options.merge(inherited_options))
        end

        alias_method :destroy_knowledgebase_category, :delete_knowledgebase_category


        def knowledgebase_comments(article, options = {})
            KayakoClient::KnowledgebaseComment.all(article, options.merge(inherited_options))
        end

        def get_knowledgebase_comment(id = :all, options = {})
            KayakoClient::KnowledgebaseComment.get(id, options.merge(inherited_options))
        end

        alias_method :find_knowledgebase_comment, :get_knowledgebase_comment

        def post_knowledgebase_comment(options = {})
            KayakoClient::KnowledgebaseComment.post(options.merge(inherited_options))
        end

        alias_method :create_knowledgebase_comment, :post_knowledgebase_comment

        def delete_knowledgebase_comment(id, options = {})
            KayakoClient::KnowledgebaseComment.delete(id, options.merge(inherited_options))
        end

        alias_method :destroy_knowledgebase_comment, :delete_knowledgebase_comment


        def news_categories(options = {})
            KayakoClient::NewsCategory.all(options.merge(inherited_options))
        end

        def get_news_category(id = :all, options = {})
            KayakoClient::NewsCategory.get(id, options.merge(inherited_options))
        end

        alias_method :find_news_category, :get_news_category

        def post_news_category(options = {})
            KayakoClient::NewsCategory.post(options.merge(inherited_options))
        end

        alias_method :create_news_category, :post_news_category

        def delete_news_category(id, options = {})
            KayakoClient::NewsCategory.delete(id, options.merge(inherited_options))
        end

        alias_method :destroy_news_category, :delete_news_category


        def news_comments(news, options = {})
            KayakoClient::NewsComment.all(news, options.merge(inherited_options))
        end

        def get_news_comment(id = :all, options = {})
            KayakoClient::NewsComment.get(id, options.merge(inherited_options))
        end

        alias_method :find_news_comment, :get_news_comment

        def post_news_comment(options = {})
            KayakoClient::NewsComment.post(options.merge(inherited_options))
        end

        alias_method :create_news_comment, :post_news_comment

        def delete_news_comment(id, options = {})
            KayakoClient::NewsComment.delete(id, options.merge(inherited_options))
        end

        alias_method :destroy_news_comment, :delete_news_comment


        def news_items(*args)
            options = args.last.is_a?(Hash) ? args.pop : {}
            args << options.merge(inherited_options)
            KayakoClient::NewsItem.all(*args)
        end

        alias_method :news, :news_items

        def get_news_item(id = :all, options = {})
            KayakoClient::NewsItem.get(id, options.merge(inherited_options))
        end

        alias_method :find_news_item, :get_news_item

        def post_news_item(options = {})
            KayakoClient::NewsItem.post(options.merge(inherited_options))
        end

        alias_method :create_news_item, :post_news_item

        def delete_news_item(id, options = {})
            KayakoClient::NewsItem.delete(id, options.merge(inherited_options))
        end

        alias_method :destroy_news_item, :delete_news_item


        def news_subscribers(options = {})
            KayakoClient::NewsSubscriber.all(options.merge(inherited_options))
        end

        def get_news_subscriber(id = :all, options = {})
            KayakoClient::NewsSubscriber.get(id, options.merge(inherited_options))
        end

        alias_method :find_news_subscriber, :get_news_subscriber

        def post_news_subscriber(options = {})
            KayakoClient::NewsSubscriber.post(options.merge(inherited_options))
        end

        alias_method :create_news_subscriber, :post_news_subscriber

        def delete_news_subscriber(id, options = {})
            KayakoClient::NewsSubscriber.delete(id, options.merge(inherited_options))
        end

        alias_method :destroy_news_subscriber, :delete_news_subscriber


        def staff(options = {})
            KayakoClient::Staff.all(options.merge(inherited_options))
        end

        alias_method :staff_users, :staff

        def get_staff(id = :all, options = {})
            KayakoClient::Staff.get(id, options.merge(inherited_options))
        end

        alias_method :find_staff, :get_staff

        def post_staff(options = {})
            KayakoClient::Staff.post(options.merge(inherited_options))
        end

        alias_method :create_staff, :post_staff

        def delete_staff(id, options = {})
            KayakoClient::Staff.delete(id, options.merge(inherited_options))
        end

        alias_method :destroy_staff, :delete_staff


        def staff_groups(options = {})
            KayakoClient::StaffGroup.all(options.merge(inherited_options))
        end

        def get_staff_group(id = :all, options = {})
            KayakoClient::StaffGroup.get(id, options.merge(inherited_options))
        end

        alias_method :find_staff_group, :get_staff_group

        def post_staff_group(options = {})
            KayakoClient::StaffGroup.post(options.merge(inherited_options))
        end

        alias_method :create_staff_group, :post_staff_group

        def delete_staff_group(id, options = {})
            KayakoClient::StaffGroup.delete(id, options.merge(inherited_options))
        end

        alias_method :destroy_staff_group, :delete_staff_group


        def tickets(*args)
            options = args.last.is_a?(Hash) ? args.pop : {}
            args << options.merge(inherited_options)
            KayakoClient::Ticket.all(*args)
        end

        def get_ticket(id = :all, options = {})
            KayakoClient::Ticket.get(id, options.merge(inherited_options))
        end

        alias_method :find_ticket, :get_ticket

        def ticket_search(query, flags = KayakoClient::Ticket::SEARCH_CONTENTS, options = {})
            KayakoClient::Ticket.search(query, flags, options.merge(inherited_options))
        end

        def post_ticket(options = {})
            KayakoClient::Ticket.post(options.merge(inherited_options))
        end

        alias_method :create_ticket, :post_ticket

        def delete_ticket(id, options = {})
            KayakoClient::Ticket.delete(id, options.merge(inherited_options))
        end

        alias_method :destroy_ticket, :delete_ticket


        def ticket_attachments(ticket, options = {})
            KayakoClient::TicketAttachment.all(ticket, options.merge(inherited_options))
        end

        def get_ticket_attachment(ticket, id, options = {})
            KayakoClient::TicketAttachment.get(ticket, id, options.merge(inherited_options))
        end

        alias_method :find_ticket_attachment, :get_ticket_attachment

        def post_ticket_attachment(options = {})
            KayakoClient::TicketAttachment.post(options.merge(inherited_options))
        end

        alias_method :create_ticket_attachment, :post_ticket_attachment

        def delete_ticket_attachment(ticket, id, options = {})
            KayakoClient::TicketAttachment.delete(ticket, id, options.merge(inherited_options))
        end

        alias_method :destroy_ticket_attachment, :delete_ticket_attachment


        def ticket_count(options = {})
            KayakoClient::TicketCount.get(options.merge(inherited_options))
        end


        def ticket_custom_fields(ticket, options = {})
            KayakoClient::TicketCustomField.get(ticket, options.merge(inherited_options))
        end

        def post_ticket_custom_fields(options = {})
            KayakoClient::TicketCustomField.post(options.merge(inherited_options))
        end

        alias_method :create_ticket_custom_fields, :post_ticket_custom_fields


        def ticket_notes(ticket, options = {})
            KayakoClient::TicketNote.all(ticket, options.merge(inherited_options))
        end

        def get_ticket_note(ticket, id, options = {})
            KayakoClient::TicketNote.get(ticket, id, options.merge(inherited_options))
        end

        alias_method :find_ticket_note, :get_ticket_note

        def post_ticket_note(options = {})
            KayakoClient::TicketNote.post(options.merge(inherited_options))
        end

        alias_method :create_ticket_note, :post_ticket_note

        def delete_ticket_note(ticket, id, options = {})
            KayakoClient::TicketNote.delete(ticket, id, options.merge(inherited_options))
        end

        alias_method :destroy_ticket_note, :delete_ticket_note


        def ticket_posts(ticket, options = {})
            KayakoClient::TicketPost.all(ticket, options.merge(inherited_options))
        end

        def get_ticket_post(ticket, id, options = {})
            KayakoClient::TicketPost.get(ticket, id, options.merge(inherited_options))
        end

        alias_method :find_ticket_post, :get_ticket_post

        def post_ticket_post(options = {})
            KayakoClient::TicketPost.post(options.merge(inherited_options))
        end

        alias_method :create_ticket_post, :post_ticket_post

        def delete_ticket_post(ticket, id, options = {})
            KayakoClient::TicketPost.delete(ticket, id, options.merge(inherited_options))
        end

        alias_method :destroy_ticket_post, :delete_ticket_post


        def ticket_priorities(options = {})
            KayakoClient::TicketPriority.all(options.merge(inherited_options))
        end

        def get_ticket_priority(id = :all, options = {})
            KayakoClient::TicketPriority.get(id, options.merge(inherited_options))
        end

        alias_method :find_ticket_priority, :get_ticket_priority


        def ticket_statuses(options = {})
            KayakoClient::TicketStatus.all(options.merge(inherited_options))
        end

        def get_ticket_status(id = :all, options = {})
            KayakoClient::TicketStatus.get(id, options.merge(inherited_options))
        end

        alias_method :find_ticket_status, :get_ticket_status


        def ticket_time_tracks(ticket, options = {})
            KayakoClient::TicketTimeTrack.all(ticket, options.merge(inherited_options))
        end

        def get_ticket_time_track(ticket, id, options = {})
            KayakoClient::TicketTimeTrack.get(ticket, id, options.merge(inherited_options))
        end

        alias_method :find_ticket_time_track, :get_ticket_time_track

        def post_ticket_time_track(options = {})
            KayakoClient::TicketTimeTrack.post(options.merge(inherited_options))
        end

        alias_method :create_ticket_time_track, :post_ticket_time_track

        def delete_ticket_time_track(ticket, id, options = {})
            KayakoClient::TicketTimeTrack.delete(ticket, id, options.merge(inherited_options))
        end

        alias_method :destroy_ticket_time_track, :delete_ticket_time_track


        def ticket_types(options = {})
            KayakoClient::TicketType.all(options.merge(inherited_options))
        end

        def get_ticket_type(id = :all, options = {})
            KayakoClient::TicketType.get(id, options.merge(inherited_options))
        end

        alias_method :find_ticket_type, :get_ticket_type


        def troubleshooter_attachments(step, options = {})
            KayakoClient::TroubleshooterAttachment.all(step, options.merge(inherited_options))
        end

        def get_troubleshooter_attachment(step, id, options = {})
            KayakoClient::TroubleshooterAttachment.get(step, id, options.merge(inherited_options))
        end

        alias_method :find_troubleshooter_attachment, :get_troubleshooter_attachment

        def post_troubleshooter_attachment(options = {})
            KayakoClient::TroubleshooterAttachment.post(options.merge(inherited_options))
        end

        alias_method :create_troubleshooter_attachment, :post_troubleshooter_attachment

        def delete_troubleshooter_attachment(step, id, options = {})
            KayakoClient::TroubleshooterAttachment.delete(step, id, options.merge(inherited_options))
        end

        alias_method :destroy_troubleshooter_attachment, :delete_troubleshooter_attachment


        def troubleshooter_categories(options = {})
            KayakoClient::TroubleshooterCategory.all(options.merge(inherited_options))
        end

        def get_troubleshooter_category(id = :all, options = {})
            KayakoClient::TroubleshooterCategory.get(id, options.merge(inherited_options))
        end

        alias_method :find_troubleshooter_category, :get_troubleshooter_category

        def post_troubleshooter_category(options = {})
            KayakoClient::TroubleshooterCategory.post(options.merge(inherited_options))
        end

        alias_method :create_troubleshooter_category, :post_troubleshooter_category

        def delete_troubleshooter_category(id, options = {})
            KayakoClient::TroubleshooterCategory.delete(id, options.merge(inherited_options))
        end

        alias_method :destroy_troubleshooter_category, :delete_troubleshooter_category


        def troubleshooter_comments(step, options = {})
            KayakoClient::TroubleshooterComment.all(step, options.merge(inherited_options))
        end

        def get_troubleshooter_comment(id = :all, options = {})
            KayakoClient::TroubleshooterComment.get(id, options.merge(inherited_options))
        end

        alias_method :find_troubleshooter_comment, :get_troubleshooter_comment

        def post_troubleshooter_comment(options = {})
            KayakoClient::TroubleshooterComment.post(options.merge(inherited_options))
        end

        alias_method :create_troubleshooter_comment, :post_troubleshooter_comment

        def delete_troubleshooter_comment(id, options = {})
            KayakoClient::TroubleshooterComment.delete(id, options.merge(inherited_options))
        end

        alias_method :destroy_troubleshooter_comment, :delete_troubleshooter_comment


        def troubleshooter_steps(options = {})
            KayakoClient::TroubleshooterStep.all(options.merge(inherited_options))
        end

        def get_troubleshooter_step(id = :all, options = {})
            KayakoClient::TroubleshooterStep.get(id, options.merge(inherited_options))
        end

        alias_method :find_troubleshooter_step, :get_troubleshooter_step

        def post_troubleshooter_step(options = {})
            KayakoClient::TroubleshooterStep.post(options.merge(inherited_options))
        end

        alias_method :create_troubleshooter_step, :post_troubleshooter_step

        def delete_troubleshooter_step(id, options = {})
            KayakoClient::TroubleshooterStep.delete(id, options.merge(inherited_options))
        end

        alias_method :destroy_troubleshooter_step, :delete_troubleshooter_step


        def users(marker = nil, limit = nil, options = {})
            KayakoClient::User.all(marker, limit, options.merge(inherited_options))
        end

        def get_user(id = :all, options = {})
            KayakoClient::User.get(id, options.merge(inherited_options))
        end

        alias_method :find_user, :get_user

        def user_search(query, options = {})
            KayakoClient::User.search(query, options.merge(inherited_options))
        end

        def post_user(options = {})
            KayakoClient::User.post(options.merge(inherited_options))
        end

        alias_method :create_user, :post_user

        def delete_user(id, options = {})
            KayakoClient::User.delete(id, options.merge(inherited_options))
        end

        alias_method :destroy_user, :delete_user


        def user_groups(options = {})
            KayakoClient::UserGroup.all(options.merge(inherited_options))
        end

        def get_user_group(id = :all, options = {})
            KayakoClient::UserGroup.get(id, options.merge(inherited_options))
        end

        alias_method :find_user_group, :get_user_group

        def post_user_group(options = {})
            KayakoClient::UserGroup.post(options.merge(inherited_options))
        end

        alias_method :create_user_group, :post_user_group

        def delete_user_group(id, options = {})
            KayakoClient::UserGroup.delete(id, options.merge(inherited_options))
        end

        alias_method :destroy_user_group, :delete_user_group


        def user_organizations(options = {})
            KayakoClient::UserOrganization.all(options.merge(inherited_options))
        end

        def get_user_organization(id = :all, options = {})
            KayakoClient::UserOrganization.get(id, options.merge(inherited_options))
        end

        alias_method :find_user_organization, :get_user_organization

        def post_user_organization(options = {})
            KayakoClient::UserOrganization.post(options.merge(inherited_options))
        end

        alias_method :create_user_organization, :post_user_organization

        def delete_user_organization(id, options = {})
            KayakoClient::UserOrganization.delete(id, options.merge(inherited_options))
        end

        alias_method :destroy_user_organization, :delete_user_organization


        def custom_fields(options = {})
            KayakoClient::CustomField.all(options.merge(inherited_options))
        end

        def custom_field_options(custom_field_id, options = {})
            KayakoClient::CustomFieldOption.all(custom_field_id, options.merge(inherited_options))
        end

    end
end
