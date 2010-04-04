require 'rubygems'
require File.join(File.dirname(__FILE__), '..', 'model', 'customer')

class CustomerBinder
  def bind(params)
    customer = Customer.new(params[:email].to_s, params[:file_name].to_s)
    return customer
  end
end