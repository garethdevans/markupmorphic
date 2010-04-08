require 'rubygems'
require File.join(File.dirname(__FILE__), '..', 'model', 'user')

class UserValidator

  attr_accessor :email, :password, :first_name, :last_name, :errors

  def initialize(email = nil, password = nil, first_name = nil, last_name = nil, user_repository = UserRepository.new)
    @email = email
    @password = password
    @first_name = first_name
    @last_name = last_name
    @is_valid = false
    @errors = {}
    @user_repository = user_repository
  end

  public
  def validate_login
    @is_valid = email_is_valid? && password_is_valid?

    if(@is_valid) then
      email_password_match = @user_repository.check(email, password)
    else
      email_password_match = nil
    end

    @errors.clear
    add_email_error()
    add_password_error()
    add_email_password_match_error(email_password_match)
  end

  def validate_registration
    @is_valid = email_is_valid? && password_is_valid? && first_name_is_valid? && last_name_is_valid?
    @errors.clear
    add_email_error()
    add_password_error()
    add_first_name_error()
    add_last_name_error()
  end

  def bind(user = User.new)
    user.email = @email
    user.password = @password
    user.first_name = @first_name
    user.last_name = @last_name
    user
  end

  def is_valid?
    @is_valid
  end

  private
  def add_email_password_match_error(match)
    @errors.merge!({:email => "Email and password do not match"}) if !match.nil? && !match
  end
  def add_email_error()
    @errors.merge!({:email => "Please enter a valid email address"}) if !email_is_valid?
  end

  def add_password_error()
    @errors.merge!({:password => "Password must be at least 8 characters"}) if !password_is_valid?
  end

  def add_first_name_error()
    @errors.merge!({:first_name => "Please enter your first name"}) if !password_is_valid?
  end

  def add_last_name_error()
    @errors.merge!({:last_name => "Please enter your last name"}) if !password_is_valid?
  end

  def email_regex_check
    (@email =~ /^[a-zA-Z][\w\.-]*[a-zA-Z0-9]@[a-zA-Z0-9][\w\.-]*[a-zA-Z0-9]\.[a-zA-Z][a-zA-Z\.]*[a-zA-Z]$/) != nil
  end

  def email_is_valid?
    @email != nil && @email.length != 0 && email_regex_check()
  end

  def password_is_valid?
    @password != nil && @password.length >= 8
  end

  def first_name_is_valid?
    @first_name != nil && @first_name.length > 0
  end

  def last_name_is_valid?
    @last_name != nil && @last_name.length > 0
  end

end