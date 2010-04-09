require 'rubygems'
require 'digest/sha1'

class Repository
  def initialize
    @db = CouchRest.database($env[:couchdb_url])
  end
end

class UserRepository < Repository

  def create(user)
      user.database = @db
      user.save
      user
  end

  def find_by_email(email)
      if user = User.by_email(:key => email, :database => @db)
          user.database = @db
      end
      user
  end

  def check(email, password)
      if user = find_by_email(email)
          user.password == Digest::SHA1.hexdigest(password)
      end
  end

end
