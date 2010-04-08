class HomeController

  def upload(params)
    customer = customerBinder.bind(params)
    order = orderBinder.bind(params)
    if customer.is_valid? and order.is_valid? then
      order.customer = customer
      order.save
    end
  end

end