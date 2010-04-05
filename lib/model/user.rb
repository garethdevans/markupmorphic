class User
  attr_accessor :email, :file_name
                
  def initialize(email, file_name)
    @email = email
    @file_name = file_name
  end
  
end               