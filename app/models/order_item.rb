require_dependency 'the_trade/order_item'
class OrderItem < ApplicationRecord

  def confirm_paid!
    if self.good
      self.good.increment! :order_items_count
      self.good&.reload # see https://github.com/rails/rails/issues/14493
    end
    
  end

  def confirm_refund!
  
  end

 

end
