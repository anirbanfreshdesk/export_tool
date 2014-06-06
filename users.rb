require 'data_mapper'

DataMapper.setup(:default, 'mysql://root@127.0.0.1/Ruby')

class GenericUser
    include DataMapper::Resource
    storage_names[:default] = "#{$session_name}-generic_users"
    property :id,               Integer,    :key => true
    property :name,             String
    property :email,            String,     :required => true
    property :address,          Text
    property :description,      Text
    property :job_title,        String
    property :twitter_id,       String
    property :fb_profile_id,    String
    property :phone,            String
    property :mobile,           String
    property :language,         String,     :default => "en"
    property :time_zone,        String
    property :customer_id,      Integer
    property :helpdesk_agent,   Boolean,    :default => false
    property :active,           Boolean,    :default => true
    property :deleted,          Boolean,    :default => false
    property :created_at,       DateTime
    property :updated_at,       DateTime

    def to_hash
        {:name => @name, :email => @email, :address => @address,\
         :description => @description, :job_title => @job_title, :twitter_id => @twitter_id,\
        :fb_profile_id => @fb_profile_id, :phone => @phone, :mobile => @mobile, :language => @language,\
        :time_zone => @time_zone, :customer_id => @customer_id, :helpdesk_agent => @helpdesk_agent,\
        :active => @active, :deleted => @deleted, :created_at => @created_at, :updated_at => @updated_at}
    end
end

#DataMapper.finalize
#DataMapper.auto_migrate!
