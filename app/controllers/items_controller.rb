class ItemsController < ApplicationController
  before_action :set_item, only: %i[ show edit update ]

  def index
    @location = params[:location].presence_in(Item::LOCATIONS)
    @items = Item.includes(:supplier).by_name
    @items = @items.where(location: @location) if @location
  end

  def show
  end

  def new
    @item = Item.new(location: "Dry store", unit: "kg", category: "Dry goods")
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to @item, notice: "#{@item.name} added to the pantry."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @item.update(item_params)
      redirect_to @item, notice: "#{@item.name} updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private
    def set_item
      @item = Item.find(params[:id])
    end

    def item_params
      params.expect(item: %i[ name category location unit quantity par_level unit_cost_cents supplier_id notes ])
    end
end
