require 'rubygems'
require 'spec'

require File.join(File.dirname(__FILE__), '..', '..', '..', 'lib', 'binder', 'user_binder')

describe UserBinder do
  it "should bind a user from hash" do
    params = {:email => "Bill@abc.com", :password=>"password"}
    userBinder = UserBinder.new
    user = userBinder.bind(params)
    user.email.should == "Bill@abc.com"
    user.password.should == "password"
  end
end
