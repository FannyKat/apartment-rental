class Booking < ApplicationRecord
  include AASM

  # Associations
  belongs_to  :tenant, class_name: 'User'
  belongs_to  :apartment

  has_one     :owner, through: :apartment

  # Validations
  validates   :start_date, :end_date, presence: true

  # Status of booking
  aasm column: 'status' do
    state :pending, initial: true
    state :accepted
    state :rejected

    event :accepted do
      transitions from: :pending, to: :accepted
    end

    event :rejected do
      transitions from: [:pending], to: :rejected
    end

    event :pending do
      transitions from: [:rejected], to: :pending
    end
  end
end
