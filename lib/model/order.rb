require 'rubygems'
require 'couchrest'
require File.join(File.dirname(__FILE__), 'user')

class Order < CouchRest::ExtendedDocument
  timestamps!

  property :file_id
  property :file_name  
  property :status  

  def user= user
    self["user_id"] = user.id
  end
  def user
    User.get(self['user_id']) if self['user_id']
  end

  view_by :user_id

end