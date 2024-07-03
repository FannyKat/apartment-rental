class User < ApplicationRecord
  enum role: { tenant: "tenant", owner: "owner", admin: "admin" }

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # Associations
  has_many :apartments, foreign_key: 'user_id'
  has_many :bookings, through: :apartments
end
