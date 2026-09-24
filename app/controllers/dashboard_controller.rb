class DashboardController < ApplicationController
  def show
    @item_count = Item.count
    @low_stock = Item.low_stock.includes(:supplier).order(:quantity).limit(6)
    @low_stock_count = Item.low_stock.count
    @supplier_count = Supplier.count
    @open_order_count = Order.open.count if manager?
    @stock_value_cents = Item.sum("quantity * unit_cost_cents").round
    @recent = Item.includes(:supplier).order(updated_at: :desc).limit(3)
  end
end
