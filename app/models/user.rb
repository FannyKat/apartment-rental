# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  first_name             :string           default(""), not null
#  last_name              :string           default(""), not null
#  role                   :string           default("tenant"), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
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
