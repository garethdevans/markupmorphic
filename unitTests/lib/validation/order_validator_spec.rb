require 'rubygems'
require "spec"
require File.join(File.dirname(__FILE__), '..', '..', '..', 'lib', 'validation', 'order_validator')

describe OrderValidator do

  before :each do
    @logger = stub("logger")
    @logger.should_receive(:debug).any_number_of_times
    @uuid_generator = stub("uuid_generator")
    @order_validator = OrderValidator.new(@logger, @uuid_generator)
  end

  it "should create new order with generated file id when bind called" do    
    @uuid_generator.should_receive(:generate).and_return("file_id")
    order = @order_validator.bind
    order.file_id.should == "file_id"
  end

  it "should not be valid when file not present" do
    params = {:file => nil}
    @order_validator.validate(params)
    @order_validator.is_valid?.should == false
    @order_validator.errors.count.should == 1
  end

  it "should not be valid when file present but no temp file" do    
    params = {:file => {:filename => "Some file.xxx", :tempfile => nil}}
    @order_validator.validate(params)
    @order_validator.is_valid?.should == false
    @order_validator.errors.count.should == 1
  end

  it "should not be valid when file and name present but filename not present" do
    file = stub("file")
    params = {:file => {:filename => nil, :tempfile => file}}
    @order_validator.validate(params)
    @order_validator.is_valid?.should == false
    @order_validator.errors.count.should == 1
  end

  it "should not be valid when file present with temp file and name but file not a psd" do
    file = stub("file")
    params = {:file => {:filename => "Some file.xxx", :tempfile => file}}
    @order_validator.validate(params)
    @order_validator.is_valid?.should == false
    @order_validator.errors.count.should == 1
  end

  it "should be valid when file present with temp file and name and is a psd" do
    file = stub("file")
    params = {:file => {:filename => "Some file.psd", :tempfile => file}}
    @order_validator.validate(params)
    @order_validator.is_valid?.should == true
    @order_validator.errors.count.should == 0
  end

  
end