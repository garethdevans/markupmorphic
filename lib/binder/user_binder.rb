require 'rubygems'
require File.join(File.dirname(__FILE__), '..', 'model', 'user')

class UserBinder
  def bind(params)
    customer = User.new(params[:email].to_s, params[:file_name].to_s)
    return customer
  end
end