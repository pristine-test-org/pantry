class User < ApplicationRecord
  ROLES = %w[manager cook].freeze

  has_secure_password
  has_many :sessions, dependent: :destroy

  normalizes :email_address, with: ->(e) { e.strip.downcase }

  validates :name, presence: true
  validates :role, inclusion: { in: ROLES }

  def manager?
    role == "manager"
  end
end
