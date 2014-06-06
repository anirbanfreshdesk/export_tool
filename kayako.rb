require './kayako/kayako_client'
require './users'

class KayakoDesk
    def initialize username, apikey, secret_key
        authenticate username, apikey, secret_key
    end
    def authenticate username, apikey, secret_key
        KayakoClient::Base.configure do |config|
            config.api_url = username
            config.api_key = apikey
            config.secret_key = secret_key
        end
    end

    def fetch_users
        KayakoClient::User.all.each do |user|
            user_deleted = false
            user_deleted = true if (user.user_expiry != nil and user.user_expiry.to_datetime < DateTime.now)
            #customers mapping not implemented yet
            GenericUser.create(:id => user.id, :email => user.emails.first,\
                               :name => user.full_name, :created_at => user.date_line,\
                              :active => user.is_enabled, :job_title => user.designation,\
                              :phone => user.phone, :time_zone => user.date_line.zone,\
                              :deleted => user_deleted)
        end
    end

    def fetch_tickets
        t_id, gap, max_gap = 1, 0, 10
        ticketsarray = []
        while gap < max_gap do
            begin
                ticketsarray.push(KayakoClient::Ticket.get(t_id))
            rescue
                gap += 1
                next
            ensure
                t_id += 1
            end
            gap = 0
        end
        ticketsarray
    end

    def fetch_notes
        t_id, gap, max_gap = 1, 0, 10
        notesarray = []
        while gap < max_gap do
            begin
                notesarray.push(KayakoClient::TicketNote.all(t_id))
            rescue
                gap += 1
                next
            ensure
                t_id += 1
            end
            gap = 0
        end
        notesarray
    end

    def fetch_posts
        t_id, gap, max_gap = 1, 0, 10
        postsarray = []
        while gap < max_gap do
            begin
                postsarray.push(KayakoClient::TicketPost.all(t_id))
            rescue
                gap += 1
                next
            ensure
                t_id += 1
            end
            gap = 0
        end
        postsarray
    end

    def fetch_attachments
        atch_id, gap, max_gap = 1, 0, 10
        attachmentsarray = []
        while gap < max_gap do
            begin
                attachmentsarray.push(KayakoClient::TicketAttachment.get 1,atch_id)
            rescue
                gap += 1
                next
            ensure
                atch_id += 1
            end
            gap = 0
        end
        attachmentsarray
    end
end
