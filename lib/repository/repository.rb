require 'rubygems'
require 'couchrest'
require File.join(File.dirname(__FILE__), '..','env')

class Repository
  def initialize
    @db = CouchRest.database($env[:couchdb_url])
  end

  def setup_database!
    @db.create!
  end

  def delete_database!
    @db.delete!
  end

  def get_single(array)
    if array.size <= 1
        array[0]
    else
        raise TooManyError
    end
  end
end

class TooManyError < Exception

end
