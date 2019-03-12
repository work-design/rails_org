require_dependency 'rails_trade/payment_method'
class PaymentMethod < ApplicationRecord

  def account_info
    "#{account_name} / #{type}:#{bank}"
  end



end
