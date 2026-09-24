class Order < ApplicationRecord
  STATUSES = %w[draft placed received].freeze

  belongs_to :supplier

  validates :reference, presence: true, uniqueness: true
  validates :status, inclusion: { in: STATUSES }

  scope :recent_first, -> { order(created_at: :desc) }
  scope :open, -> { where.not(status: "received") }
end
