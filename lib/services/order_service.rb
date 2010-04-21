require 'rubygems'
require File.join(File.dirname(__FILE__), '..', 'repository', 'order_repository')
require File.join(File.dirname(__FILE__), '..', '..','env')

class OrderService

  def initialize(order_repository = OrderRepository.new)
      @order_repository = order_repository
  end

  def create_order(order, user, user_file)
    order.user = user
    @order_repository.save(order)
    open_file_store
    File.open(file_to_save(order), 'wb') do |file|
      file.write(user_file.read)
    end
  end

  def find_orders_for(user)    
    @order_repository.find_by_user(user)
  end

  def find_all_orders
    @order_repository.all_orders
  end

  private
  def open_file_store
    FileUtils.mkdir_p file_store_location unless File.exists?(file_store_location)
  end

  def file_store_location
    $env[:file_store]
  end

  def file_to_save(order)
    File.join(file_store_location, order.file_id)
  end

end