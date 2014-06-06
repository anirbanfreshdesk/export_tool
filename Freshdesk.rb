require 'freshdesk'

class FreshDeskExport
    def initialize companydomain, userid, password
        @client = Freshdesk.new companydomain, userid, password
    end

    def export_users
        GenericUser.all.each do |user|
            begin
                @client.post_users(user.to_hash)
            rescue
                next
            end
        end
    end
end
