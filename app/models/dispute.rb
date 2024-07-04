class Dispute < ApplicationRecord
  belongs_to :booking
  belongs_to :user

  has_one_attached :image
end
