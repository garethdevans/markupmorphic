require 'rubygems'
require 'spec'

require File.join(File.dirname(__FILE__), '..', '..', '..', 'lib', 'binder', 'customer_binder')

describe CustomerBinder do
  it "should bind a customer from hash" do
    params = {:email => "Bill@abc.com", :file_name=>"my_psd.psd"}
    customerBinder = CustomerBinder.new
    customer = customerBinder.bind(params)
    customer.email.should == "Bill@abc.com"
    customer.file_name.should == "my_psd.psd"
  end
end
