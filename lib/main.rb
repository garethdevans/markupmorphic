require 'rubygems'
require 'sinatra/base'
require 'erb'
require 'rack'

require File.join(File.dirname(__FILE__), 'validation', 'user_validator')
require File.join(File.dirname(__FILE__), 'model', 'user')

class Main < Sinatra::Base

  def user_validator
    @user_validator ||= UserValidator.new
  end
  def user_validator=(user_validator)
    @user_validator = user_validator
  end

  def user_service
    @user_service ||= UserService.new
  end
  def user_service=(user_service)
    @user_service = user_service
  end

  post '/user/login' do
    user_validator.validate_login(params)
    if user_validator.is_valid? && user_service.password_correct() then
      session["user"] = user_validator.bind
    end
    redirect '/home'
  end

  get '/user/create' do                          
    @user = User.new
    erb :register
  end

  post '/user/create' do
    user_validator.validate_registration(params)
    @user = user_validator.bind
    if user_validator.is_valid? && !user_service.exists(@user) then
      user_service.save(@user)
      session["user"] = @user
      redirect '/home'
    else
      erb :register
    end
  end

  get '/home' do
    @user = get_user()
    erb :home
  end

  private
  def authenticate
    if session["user"].nil?
      redirect '/home'
    end
  end

  def get_user
    session["user"].nil? ? User.new : session["user"]
  end
end
