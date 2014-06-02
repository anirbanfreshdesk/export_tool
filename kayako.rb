require './kayako/kayako_client'

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

    def KayakoDesk.dump_tickets ticketsarray
        ticketdump = File.new("./dumps/tickets", "w")
        if ticketdump
            ticketdump.syswrite "id~status_id~priority_id~full_name~email~subject~contents~creation_time|"
            ticketsarray.each do |ticket|
                ticketdump.syswrite "#{ticket.id}~#{ticket.status_id}~#{ticket.priority_id}~#{ticket.full_name}~#{ticket.email}~#{ticket.subject}~\"#{ticket.posts.first.contents.split.join(' ')}\"~#{ticket.creation_time}|"
            end
        else
            puts "Some error occured"
        end
    end

    def KayakoDesk.dump_notes notesarray,postsarray
        notedump = File.new("./dumps/notes", "w")
        if notedump
            notedump.syswrite "id~ticket_id~creator_staff_id~contents~creation_date~is_private|"
            postsarray.each do |posts_ticket|
                posts_ticket.each do |each_post|
                    notedump.syswrite "#{each_post.id}~#{each_post.ticket_id}~#{each_post.staff_id}~#{each_post.contents.split.join(' ')}~#{each_post.date_line}~#{each_post.is_private}|"
                end
            end
            notesarray.each do |notes_ticket|
                notes_ticket.each do |each_note|
                    notedump.syswrite "#{each_note.id}~#{each_note.ticket_id}~#{each_note.creator_staff_id}~#{each_note.contents}~#{each_note.creation_date}~true|"
                end
            end
        else
            puts "Some error occured"
        end
    end

    def KayakoDesk.dump_attachments attachmentsarray
    attachmentsdump = File.new("./dumps/attachments", "w")
        if attachmentsdump
            attachmentsdump.syswrite "id~ticket_id~ticket_note_id~file_name~file_size~file_type~contents~creation_time|"
            attachmentsarray.each do |attachment|
                attachmentsdump.syswrite "#{attachment.id}~#{attachment.ticket_id}~#{attachment.ticket_post_id}~#{attachment.file_name}~#{attachment.file_size}~#{attachment.file_type}~#{attachment.contents}~#{attachment.date_line}|"
            end
        else
            puts "Some error occured"
        end
    end
end