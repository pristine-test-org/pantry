class Item < ApplicationRecord
  CATEGORIES = %w[Produce Dairy Protein Dry\ goods Spices Oils Bakery Frozen].freeze
  LOCATIONS = %w[Dry\ store Walk-in Freezer Line].freeze
  UNITS = %w[kg g l ml each case bunch].freeze

  belongs_to :supplier, optional: true

  validates :name, presence: true, uniqueness: true
  validates :category, inclusion: { in: CATEGORIES }
  validates :location, inclusion: { in: LOCATIONS }
  validates :unit, inclusion: { in: UNITS }
  validates :quantity, :par_level, numericality: { greater_than_or_equal_to: 0 }
  validates :shelf_life_days, numericality: { only_integer: true, greater_than: 0 }, allow_nil: true

  scope :by_name, -> { order(:name) }
  scope :low_stock, -> { where("quantity < par_level") }

  def low_stock?
    quantity < par_level
  end

  def out_of_stock?
    quantity.zero?
  end

  def stock_status
    return "out" if out_of_stock?
    return "low" if low_stock?
    "ok"
  end

  def stock_value_cents
    (quantity * unit_cost_cents).round
  end
end
