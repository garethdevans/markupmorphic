require 'rubygems'
require 'sinatra/base'
require 'log4r'
require 'log4r/configurator'

log_file = File.join(File.dirname(__FILE__), 'mainlog4r.xml')
Log4r::Configurator.load_xml_file(log_file)

require File.join(File.dirname(__FILE__), 'lib', 'validation', 'user_validator')
require File.join(File.dirname(__FILE__), 'lib', 'repository', 'user_repository')
require File.join(File.dirname(__FILE__), 'lib', 'model', 'user')
require File.join(File.dirname(__FILE__), 'lib', 'services', 'order_service')
require File.join(File.dirname(__FILE__), 'lib', 'validation', 'order_validator')
require File.join(File.dirname(__FILE__), 'lib', 'model', 'order')


module Markupmorphic
  class Main < Sinatra::Base

    def logger
      @logger ||= Log4r::Logger['MainLogger']
    end
    
    def user_validator
      @user_validator ||= UserValidator.new
    end

    def user_validator=(user_validator)
      @user_validator = user_validator
    end

    def order_validator
      @order_validator ||= OrderValidator.new
    end

    def order_validator=(order_validator)
      @order_validator = order_validator
    end

    def user_repository
      @user_repository ||= UserRepository.new
    end

    def user_repository=(user_repository)
      @user_repository = user_repository
    end

    def order_service
      @order_service ||= OrderService.new
    end

    def order_service=(order_service)
      @order_service = order_service
    end
    
    def authenticate
      if get_user().nil?
        redirect '/'
      end
    end

    def get_user
      if get_id()
        user = user_repository.get_user(get_id())
        user.login if user
        user
      else
        User.new
      end
    end

    def get_id
      if session["user_id"]
        set_sliding_expiration
        session["user_id"]
      end
    end

    def set_sliding_expiration
      id = session["user_id"]
      session["user_id"] = id
    end

    get '/' do
      begin        
        @user = get_user()
        @errors = session["errors"]
        @message = session["message"]
        session["errors"] = nil
        session["message"] = nil
        logger.debug("session:" + session.to_s)
        logger.debug("user:" + @user.email.to_s + @user.first_name.to_s)
        erb :home        
      rescue Exception => e
        logger.error(e)
      end
    end

    post '/user/login' do
      begin
        logger.debug("session:" + session.to_s)
        user_validator.validate_login(params)
        if user_validator.is_valid? then
          session["user_id"] = user_repository.find_by_email(params[:email]).id
        else
          session["errors"] = user_validator.errors
        end
        redirect '/'
      rescue Exception => e
        logger.error(e)
      end            
    end
    
    get '/user/logout' do
      begin
        logger.debug("session:" + session.to_s)
        session["user_id"] = nil
        session["errors"] = nil
        redirect '/'
      rescue Exception => e
        logger.error(e)
      end
    end

    get '/user/create' do
      begin
        logger.debug("session:" + session.to_s)
        @user = User.new
        erb :register
      rescue Exception => e
        logger.error(e)
      end
    end

    post '/user/create' do
      begin
        logger.debug("session:" + session.to_s)
        user_validator.validate_registration(params)
        @user = user_validator.bind
        if user_validator.is_valid? then
          user_repository.save(@user)
          session["user_id"] = @user.id
          redirect '/'
        else
          @errors = user_validator.errors
          erb :register
        end
      rescue Exception => e
        logger.error(e)
      end
    end

    post '/order/create' do
      begin
        authenticate
        logger.debug("params" + params.to_s)
        order_validator.validate(params)
        if order_validator.is_valid?
          order_service.create_order(order_validator.bind, get_user, params[:file][:tempfile])
          session["message"] = "Order created successfully"
          session["errors"] = nil
        else
          session["message"] = nil
          session["errors"] = order_validator.errors
        end
        redirect '/'
      rescue Exception => e
        logger.error(e)
      end
    end

    get '/orders' do
      begin
        authenticate
        @user = get_user
        @orders = order_service.find_orders_for(@user)
        erb :orders
      rescue Exception => e
        logger.error(e)
      end
    end

    get '/orders/all' do
      begin
        authenticate
        @user = get_user
        @orders = order_service.find_all_orders
        erb :orders
      rescue Exception => e
        logger.error(e)
      end
    end

  end

end