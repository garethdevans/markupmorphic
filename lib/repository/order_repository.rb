require 'rubygems'
require 'couchrest'

require File.join(File.dirname(__FILE__), 'repository')
require File.join(File.dirname(__FILE__), '..', '..','env')

class OrderRepository < Repository

  def save(order)
    begin
      @logger.debug("Saving order:" + order.to_s)
      order.database = @db
      order.save
      order
    rescue Exception => e
      @logger.error(e)
      raise $!
    end
  end

  def find_by_user(user)
    begin
      @logger.debug("user:" + user.email)
      orders = Order.by_user_id(:key => user.id, :database => @db)
      orders.each do |order|
          order.user = user
          order.database = @db
      end
      orders
    rescue RestClient::ResourceNotFound
      nil
    rescue Exception => e
      @logger.error(e)
      raise $!
    end
  end

  def all_orders
    begin
      Order.all(:database => @db).map do |order| 
        order.database = @db
        order
      end
    rescue RestClient::ResourceNotFound
      nil
    rescue Exception => e
      @logger.error(e)
      raise $!
    end
  end

end

