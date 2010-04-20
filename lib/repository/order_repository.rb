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

end

