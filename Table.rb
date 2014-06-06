require 'active_support/all'

class Ticket
  def initialize
    @id = nil
    @display_id = nil
    @email = "noname@nodomain.com"
    @requester_id = nil
    @subject = nil
    @description = nil
    @description_html = nil
    @status = nil
    @priority = nil
    @source = nil
    @deleted = false
    @spam = false
    @responder_id = nil
    @group_id = nil
    @ticket_type = nil
    @delta = false
    @urgent = false
    @to_email = []
    @cc_email = []
    @fwd_email = []
    @isescalated = false
    @due_by = DateTime.new(0000)
    @created_at = DateTime.new(0000)
    @first_assigned_at = DateTime.new(0000)
    @resolved_at = DateTime.new(0000)
    @status_updated_at = DateTime.new(0000)
    @updated_at = DateTime.new(0000)
    @resolution_time = -1
    @custom_fields = []
    @attachments = []
  end

  def [] attr_hash
    raise "Have to pass hash as argument" unless attr_hash.is_a? Symbol
    eval("@" + attr_hash.to_s)
  end

  def []= attr_hash,value
    raise "Have to pass hash as argument" unless attr_hash.is_a? Symbol
    eval("@" + attr_hash.to_s + "= #{value}")
  end
end

T = Ticket.new
p T[:id]
T[:id] = 1
p T[:id]
p T
