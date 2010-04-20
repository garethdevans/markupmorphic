require 'rubygems'
require "spec"
require File.join(File.dirname(__FILE__), '..', '..', '..', 'lib', 'validation', 'user_validator')

describe UserValidator do
  before :each do
    @logger = stub("logger")
    @logger.should_receive(:debug)
    @user_repository = mock("user_repository")
    @user_validator = UserValidator.new(@user_repository, @logger)
  end

  it "should not be valid for login when email blank" do
    @user_validator.validate_login({:email =>"", :password => "password"})
    @user_validator.is_valid?.should == false
    @user_validator.errors.count.should == 1
  end

  it "should not be valid for login when email nil" do
    @user_validator = @user_validator
    @user_validator.validate_login({:email => nil, :password => "password"})
    @user_validator.is_valid?.should == false
    @user_validator.errors.count.should == 1
  end

  it "should not be valid for login when email not valid" do
    @user_validator.validate_login({:email => "a", :password => "password"})
    @user_validator.is_valid?.should == false
    @user_validator.errors.count.should == 1
  end

  it "should not be valid for login when email and password valid but do not match" do
    @user_repository.should_receive(:check).with("aaa@bbb.com", "password").and_return(false)
    @user_validator.validate_login({:email => "aaa@bbb.com", :password => "password"})
    @user_validator.is_valid?.should == false
    @user_validator.errors.count.should == 1
    @user_validator.errors.all? {|message| message.eql?("Email and password do not match")}
  end

  it "should not be valid for login when password nil" do
    @user_validator.validate_login({:email => "oiuweoiruow@lkjlskjdf.com", :password => nil})
    @user_validator.is_valid?.should == false
    @user_validator.errors.count.should == 1
  end

  it "should not be valid for login when password less than 8 characters" do
    @user_validator.validate_login({:email => "aaa@bbb.com", :password => "less"})
    @user_validator.is_valid?.should == false
    @user_validator.errors.count.should == 1
  end

  it "should be valid for login when password valid" do
    @user_repository.should_receive(:check).with("aaa@bbb.com", "password").and_return(true)
    @user_validator.validate_login({:email => "aaa@bbb.com", :password => "password"})
    @user_validator.is_valid?.should == true
    @user_validator.errors.count.should == 0
  end

  it "should not be valid for login when password nil and email nil" do
    @user_validator.validate_login({:email => nil, :password => nil})
    @user_validator.is_valid?.should == false
    @user_validator.errors.count.should == 2
  end

  it "should not be valid for registration when all fields nil" do
    @user_validator.validate_registration({:email => nil, :password => nil, :first_name => nil, :last_name => nil})
    @user_validator.is_valid?.should == false
    @user_validator.errors.count.should == 4
  end

  it "should not be valid for registration when all empty" do
    @user_validator.validate_registration({:email => "", :password => "", :first_name => "", :last_name => ""})
    @user_validator.is_valid?.should == false
    @user_validator.errors.count.should == 4
  end

  it "should not be valid for registration when all valid but email exists" do
    @user_repository.should_receive(:find_by_email).with("aaa@bbb.com").twice.and_return(User.new)
    @user_validator.validate_registration({:email => "aaa@bbb.com", :password => "password", :first_name => "Bob", :last_name => "Smith"})
    @user_validator.is_valid?.should == false
    @user_validator.errors.count.should == 1
  end

  it "should be valid for registration when all valid and email does not exist" do
    @user_repository.should_receive(:find_by_email).with("aaa@bbb.com").twice.and_return(nil)
    @user_validator.validate_registration({:email => "aaa@bbb.com", :password => "password", :first_name => "Bob", :last_name => "Smith"})
    @user_validator.is_valid?.should == true
    @user_validator.errors.count.should == 0
  end

end