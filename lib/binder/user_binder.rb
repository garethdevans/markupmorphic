require 'rubygems'
require File.join(File.dirname(__FILE__), '..', 'model', 'user')

class UserBinder
  def bind(params)
    user = User.new(params[:email].to_s, params[:password].to_s)
    return user
  end
end