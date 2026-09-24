class Supplier < ApplicationRecord
  has_many :items, dependent: :nullify
  has_many :orders, dependent: :restrict_with_error

  validates :name, presence: true
  validates :lead_time_days, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  scope :by_name, -> { order(:name) }
end
