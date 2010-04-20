require 'rubygems'
require 'couchrest'

class Order < CouchRest::ExtendedDocument
  property :time_stamp
  property :file_id
  property :file_name

  property :user, :cast_as => 'User'

  
end