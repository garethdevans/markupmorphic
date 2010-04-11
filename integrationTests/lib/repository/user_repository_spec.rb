require "spec"
require 'digest/sha1'
require File.join(File.dirname(__FILE__), '..', '..', '..', 'lib', 'model', 'user')
require File.join(File.dirname(__FILE__), '..', '..', '..', 'lib', 'repository', 'user_repository')

describe UserRepository do

  before(:all) do
    @user_repository = UserRepository.new
    @user_repository.setup_database!
  end
  
  it "should save new user" do
    user = User.new(:email => "bob@smith.com", :password => "password", :first_name => "Bob", :last_name => "Smith") 
    @user_repository.save(user)
    
  end

  it "should retrieve saved user by email" do
    user = User.new(:email => "bill@smith.com", :password => "password", :first_name => "Bill", :last_name => "Smith")
    @user_repository.save(user)
    user_found = @user_repository.find_by_email("bill@smith.com")
    user.email.should == user_found.email
    user.first_name.should == user_found.first_name
    user.last_name.should == user_found.last_name
    user.password.should == user_found.password
  end

  it "should return true when email and password match" do
    user = User.new(:email => "fred@smith.com", :password => "abcd1234", :first_name => "Fred", :last_name => "Smith")
    @user_repository.save(user)
    @user_repository.check("fred@smith.com", "abcd1234").should == true
  end

  after(:all) do
    @user_repository.delete_database!
  end

end