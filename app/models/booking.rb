class Booking < ApplicationRecord
  belongs_to :apartment

  belongs_to :user

  # Status of booking
  enum status: { pending: 0, accepted: 1, rejected: 2 }

end
