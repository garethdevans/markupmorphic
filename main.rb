require 'rubygems'
require 'sinatra/base'
require File.join(File.dirname(__FILE__), 'lib', 'validation', 'user_validator')
require File.join(File.dirname(__FILE__), 'lib', 'model', 'user')


module Markupmorphic
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

    def authenticate
      if get_id().nil?
        redirect '/'
      end
    end

    def get_user
      if get_id().nil?
        User.new
      else
        user = user_repository.get_user(get_id())
        user.login
        user
      end
    end

    def get_id
      return session["user_id"] if !session["user_id"].nil?
    end
    
    get '/' do
      puts "session:" + session.to_s
      @user = get_user()
      erb :home
    end

    post '/user/login' do
      user_validator.validate_login(params)
      if user_validator.is_valid? then
        @user = user_repository.find_by_email(params[:email])
        session["user_id"] = @user.id
      end
      puts "session:" + session.to_s
      redirect '/'
    end
    
    get '/user/logout' do
      session["user_id"] = nil
      redirect '/'
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
        session["user_id"] = @user.id
        redirect '/'
      else
        erb :register
      end
    end

  end
end