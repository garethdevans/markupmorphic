require "spec"

describe Customer do

  it "should not be valid when email blank" do
    customer = Customer.new("", "file")
    customer.is_valid.should == false
  end
    
end