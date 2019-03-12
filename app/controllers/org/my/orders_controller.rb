class My::OrdersController < Org::My::BaseController

  def confirm
    @order = Order.find params[:id]
    @order.update params.fetch(:order, {}).permit!

    redirect_to dinners_my_orders_url
  end

  def dinners
    dinners_params = {
        office_id: [current_user.office_id, nil]
    }
    q_params = params.fetch(:q, {}).permit!
    q_params.merge! dinners_params
    if Dinner.enabled?
      @dinners = Dinner.default_where(q_params)
    else
      @dinners = Dinner.none
    end

    default_params = {
      'order_items.good_type': 'Dinner',
      'created_at-gte': Date.today.at_beginning_of_day,
      'created_at-lte': Date.today.at_end_of_day
    }
    @orders = current_buyer.orders.default_where(default_params).page(params[:page])
    if @orders.empty?
      redirect_to new_my_order_path
    else
      render :dinners
    end
  end

  def new
    dinners_params = {
        office_id: [current_user.office_id, nil]
    }
    if Dinner.enabled?
      @dinners = Dinner.default_where(dinners_params)
    else
      @dinners = Dinner.none
    end
  end

  def create
    @dinner = Dinner.find(params[:dinner_id])
    @order = @dinner.generate_order(current_user)
    @order.update(note: params[:note])
    redirect_to dinners_my_orders_url
  end

  def remove
    if Dinner.enabled?
      @order  = Order.find(params[:id])
      @order.destroy
    else
      flash[:notice] = "You can't delete order after 5PM"
    end
    redirect_to dinners_my_orders_url
  end

end
