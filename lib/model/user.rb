require 'rubygems'
require 'couchrest'

class User < CouchRest::ExtendedDocument
    property :first_name
    property :last_name
    property :email
    property :password

    view_by :email

    def errors=errors
      @errors = errors  
    end
    def errors
      @errors ||= {}
    end
    def is_logged_in?
      return false
    end
end