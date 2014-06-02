load './imports.rb'


puts "Which helpdesk service do you wish to import from?"
puts "1.Kayako"
print "> "
helpdeskservice = gets
helpdeskservice.chomp!
case helpdeskservice
when "1"
    print "Input domain name : "
    userdomain = gets
    print "Input api key : "
    apikey = gets
    print "Input secret key : "
    secretkey = gets
    userdomain.chomp!
    apikey.chomp!
    secretkey.chomp!
    G = KayakoDesk.new userdomain,apikey,secretkey
    while true
        puts "What do you wish to do?"
        puts "1.Export tickets"
        puts "2.Export notes"
        puts "3.Export attachments"
        puts "4.Exit"
        print "> "
        option = gets
        option.chomp!
        case option
        when "1"
            KayakoDesk.dump_tickets G.fetch_tickets
        when "2"
            KayakoDesk.dump_notes G.fetch_notes,G.fetch_posts
        when "3"
            KayakoDesk.dump_attachments G.fetch_attachments
        when "4"
            break
        end
    end
end
