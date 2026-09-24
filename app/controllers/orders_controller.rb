class OrdersController < ApplicationController
  before_action :require_manager

  def index
    @status = params[:status].presence_in(Order::STATUSES)
    @orders = Order.includes(:supplier).recent_first
    @orders = @orders.where(status: @status) if @status
  end
end
