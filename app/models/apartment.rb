class Apartment < ApplicationRecord
  # Associations
  belongs_to :owner, class_name: 'User'

  has_many :bookings, dependent: :destroy

  # Active Storage image
  has_one_attached :image do |attachable|
    attachable.variant :medium, resize_to_limit: [300, 300]
  end

  # Validations
  validates :title, :location, :rent_amount, :number_of_bedrooms, :amenities, presence: true

  def formated_amount
    (self.rent_amount ? self.rent_amount.to_s + ' €' : "prix non renseigné")
  end
end
