require 'rubygems'
require 'couchrest'
require 'digest/sha1'
require File.join(File.dirname(__FILE__), 'repository')
require File.join(File.dirname(__FILE__), '..','env')

class UserRepository < Repository

  def save(user)
      user.password = Digest::SHA1.hexdigest(user.password)
      user.database = @db
      user.save
      user
  end

  def find_by_email(email)
      if user = get_single(User.by_email(:key => email, :database => @db))
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

