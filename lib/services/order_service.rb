require 'rubygems'
require File.join(File.dirname(__FILE__), '..', 'repository', 'order_repository')
require File.join(File.dirname(__FILE__), '..', '..','env')

class OrderService

  def initialize(order_repository = OrderRepository.new)
      @order_repository = order_repository
  end

  def create_order(order, user, user_file)
    order = order_validator.bind
    order.user = user
    @order_repository.save(order)
    open_file_store(file_store_location)
    File.open(file_to_save(order), 'wb') do |file|
      file.write(user_file.read)
    end
  end

  private
  def open_file_store(file_store)
    FileUtils.mkdir_p file_store unless File.exists?(file_store)
  end

  def file_store_location
    $env[:file_store]
  end

  def file_to_save(order)
    File.join(file_store_location, order.file_name)
  end

end