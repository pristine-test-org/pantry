class ReportsController < ApplicationController
  def index
    @by_location = Item.group(:location).sum("quantity * unit_cost_cents").transform_values(&:round)
    @by_category = Item.group(:category).order(:category).pluck(:category, Arel.sql("COUNT(*)"), Arel.sql("SUM(CASE WHEN quantity < par_level THEN 1 ELSE 0 END)"))
    @total_cents = @by_location.values.sum
  end
end
