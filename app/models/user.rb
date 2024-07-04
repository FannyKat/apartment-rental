class User < ApplicationRecord
  enum role: { tenant: "tenant", owner: "owner", admin: "admin" }

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # Associations
  has_many :apartments, foreign_key: 'owner_id'
  has_many :bookings, foreign_key: 'tenant_id'

  has_one_attached :avatar

  # Validations
  validates :email, :first_name, :last_name, presence: true

  def full_name_humanized
    "#{self.first_name}".humanize + " " + "#{self.last_name}".humanize
  end
end
