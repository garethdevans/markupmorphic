require 'rubygems'
require 'couchrest'

class User < CouchRest::ExtendedDocument
    property :first_name
    property :last_name
    property :email
    property :password

    view_by :email
end