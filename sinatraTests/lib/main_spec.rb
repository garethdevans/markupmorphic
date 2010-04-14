require 'rubygems'
require 'spec'
require 'rack/test'
require File.join(File.dirname(__FILE__), '..', '..', 'lib', 'main')
require File.join(File.dirname(__FILE__), '..', '..', 'lib', 'model', 'user')




describe Main do
  include Rack::Test::Methods
  
  def app
    Main
  end

  it "should return body containing hell" do
    get '/test', :user => User.new
    last_response.should be_ok
    last_response.body.include?('Hell').should be_true
  end
  
  it "should return body containing hell" do
    get '/home'
    last_response.should be_ok
    last_response.body.include?('Welcome').should be_true
  end

end