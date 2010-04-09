require 'rubygems'
require File.join(File.dirname(__FILE__), '..', 'repository', 'user_repository')


class UserService

  def initialize(user_repository = UserRepository.new)
      @user_repository = user_repository
  end

  
end