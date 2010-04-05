require "spec"
require File.join(File.dirname(__FILE__), '..', '..', '..', 'lib', 'model', 'user')

describe User do

  it "should not be valid when email blank" do
    user = User.new("", "password")
    user.is_valid.should == false
    user.errors.count.should == 1
  end

  it "should not be valid when email nil" do
    user = User.new(nil, "password")
    user.is_valid.should == false
    user.errors.count.should == 1
  end

  it "should not be valid when email not valid" do
    user = User.new("a", "password")
    user.is_valid.should == false
    user.errors.count.should == 1
  end

  it "should be valid when email valid" do
    user = User.new("aaa@bbb.com", "password")
    user.is_valid.should == true
    user.errors.count.should == 0
  end

  it "should not be valid when password nil" do
    user = User.new("oiuweoiruow@lkjlskjdf.com", nil)
    user.is_valid.should == false
    user.errors.count.should == 1
  end

  it "should not be valid when password less than 8 characters" do
    user = User.new("aaa@bbb.com", "less")
    user.is_valid.should == false
    user.errors.count.should == 1
  end

  it "should be valid when password valid" do
    user = User.new("aaa@bbb.com", "valid_password")
    user.is_valid.should == true
    user.errors.count.should == 0
  end

  it "should not be valid when password nil and email nil" do
    user = User.new(nil, nil)
    user.is_valid.should == false
    user.errors.count.should == 2
  end

end