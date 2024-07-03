class Apartment < ApplicationRecord
  belongs_to :user

  has_many :bookings, dependent: :destroy

  has_one_attached :image

  # Validations
  validates :location, presence: true
  validates :rent_amount, presence: true
  validates :number_of_bedrooms, presence: true
end
