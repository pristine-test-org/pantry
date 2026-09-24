class SuppliersController < ApplicationController
  def index
    @suppliers = Supplier.by_name.includes(:items)
  end

  def show
    @supplier = Supplier.find(params[:id])
    @items = @supplier.items.by_name
    @orders = @supplier.orders.recent_first.limit(5) if manager?
  end
end
