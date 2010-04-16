require 'rubygems'
require 'couchrest'
require 'digest/sha1'

require File.join(File.dirname(__FILE__), 'repository')
require File.join(File.dirname(__FILE__), '..', '..','env')

class UserRepository < Repository

  def save(user)
    begin
      @logger.debug("Saving user:" + user.to_s)
      user.password = Digest::SHA1.hexdigest(user.password)
      user.database = @db
      user.save
      user
    rescue Exception => e
      @logger.error(e)
      raise $!
    end
  end

  def find_by_ema/il(email)
    begin
      @logger.debug("email:" + email)
      if user = get_single(User.by_email(:key => email, :database => @db))
          user.database = @db
      end
      user
    rescue RestClient::ResourceNotFound
      nil
    rescue Exception => e
      @logger.error(e)
      raise $!
    end    
  end

  def check(email, password)
    begin
      @logger.debug("email:" + email + ", password:" + password)
      if user = find_by_email(email)
        user.password == Digest::SHA1.hexdigest(password)
      end
    rescue Exception => e
      @logger.error(e)
      raise $!
    end
  end

  def get_user(id)
    begin
      @logger.debug("id:" + id)
      if user = User.get(id, @db)
          user.database = @db
      end
      user
    rescue Exception => e
      @logger.error(e)
      raise $!
    end
  end
end

