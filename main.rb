require 'rubygems'
require 'sinatra/base'
require 'erb'

require File.join(File.dirname(__FILE__), 'validation', 'user_validator')
require File.join(File.dirname(__FILE__), 'model', 'user')

class Main < Sinatra::Base

  def user_validator
    @user_validator ||= UserValidator.new
  end
  def user_validator=(user_validator)
    @user_validator = user_validator
  end

  def user_repository
    @user_repository ||= UserRepository.new
  end
  def user_repository=(user_repository)
    @user_repository = user_repository
  end


  post '/user/login' do
    user_validator.validate_login(params)
    if user_validator.is_valid? then
      @user = user_repository.find_by_email(params[:email])
      @user.login
      session["user_id"] = @user.id
    end
    puts "session:" + session.to_s
    redirect '/home'
  end
  

  get '/user/logout' do
    session["user_id"] = nil
    redirect '/home'
  end

  get '/user/create' do
    @user = User.new
    erb :register
  end

  post '/user/create' do
    user_validator.validate_registration(params)
    @user = user_validator.bind
    if user_validator.is_valid? then
      user_repository.save(@user)
      @user.login
      session["user_id"] = @user.id
      redirect '/home'
    else
      erb :register
    end
  end

  get '/home' do
    puts "session:" + session.to_s
    @user = get_user()
    erb :home
  end

  private
  def authenticate
    if session["user_id"].nil?
      redirect '/home'
    end
  end

  def get_user
    get_id().nil? ? User.new : user_repository.get_user(get_id())
  end

  def get_id
    return session["user_id"] if !session["user_id"].nil?
  end
end
