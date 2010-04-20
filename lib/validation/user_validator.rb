require 'rubygems'
require 'log4r'
require File.join(File.dirname(__FILE__), '..', 'model', 'user')
require File.join(File.dirname(__FILE__), '..', 'repository', 'user_repository')

class UserValidator

  attr_accessor :email, :password, :first_name, :last_name, :errors

  def initialize(user_repository = UserRepository.new, logger = Log4r::Logger['MainLogger'])
    @user_repository = user_repository
    @logger = logger
    @errors = {}    
  end

  public
  def validate_login(params)
    @logger.debug("params:" + params.to_s)
    setup(params)
    @is_valid = check(email, password)
    @errors.clear
    add_email_error()
    add_password_error()
    add_email_password_match_error(@is_valid) if email_is_valid? && password_is_valid?
  end

  def validate_registration(params)
    @logger.debug("params:" + params.to_s)
    setup(params)
    @is_valid = email_is_valid? && password_is_valid? && first_name_is_valid? && last_name_is_valid? && user_does_not_exist?()
    @errors.clear
    add_email_error()
    add_password_error()
    add_first_name_error()
    add_last_name_error()
    add_user_does_not_exist() if email_is_valid?
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
  def setup(params)
    @email = params[:email]
    @password = params[:password]
    @first_name = params[:first_name]
    @last_name = params[:last_name]
    @is_valid = false
  end

  def check(email, password)
    email_is_valid? && password_is_valid? && @user_repository.check(email, password)
  end

  def user_does_not_exist?
    email_is_valid? && @user_repository.find_by_email(@email).nil?
  end

  def add_email_password_match_error(match)
    @errors.merge!({:email => "Email and password do not match"}) if !match.nil? && !match
  end
  def add_email_error
    @errors.merge!({:email => "Please enter a valid email address"}) if !email_is_valid?
  end

  def add_password_error
    @errors.merge!({:password => "Password must be at least 8 characters"}) if !password_is_valid?
  end

  def add_first_name_error
    @errors.merge!({:first_name => "Please enter your first name"}) if !password_is_valid?
  end

  def add_last_name_error
    @errors.merge!({:last_name => "Please enter your last name"}) if !password_is_valid?
  end

  def add_user_does_not_exist
    @errors.merge!({:user_exists => "Email address already in use"}) if !user_does_not_exist?    
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