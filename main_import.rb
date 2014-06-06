require './Freshdesk.rb'

session_list = IO.readlines('session_list')
session_list.each do |x| x.chomp! end

puts "Which session do you wish to import\n"
session_list.each_with_index do |x,i|
    puts "#{i}. #{x}"
end

print "> "
$session_name = session_list[gets.to_i]
require './imports.rb'
print "Input company domain name : "
companydomain = gets
print "Input user id : "
userid = gets
print "Input password : "
password = gets
companydomain.chomp!
userid.chomp!
password.chomp!

F = FreshDeskExport.new companydomain, userid, password
F.export_users
