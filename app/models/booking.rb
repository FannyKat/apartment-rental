# == Schema Information
#
# Table name: bookings
#
#  id           :bigint           not null, primary key
#  tenant_id    :bigint           not null
#  apartment_id :bigint           not null
#  status       :string           default("pending"), not null
#  message      :text             default(""), not null
#  start_date   :datetime
#  end_date     :datetime
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
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
    state :canceled

    event :accepted do
      transitions from: :pending, to: :accepted
    end

    event :rejected do
      transitions from: [:pending], to: :rejected
    end

    event :pending do
      transitions from: [:rejected], to: :pending
    end

    event :canceled do
      transitions from: [:accepted], to: :pending
    end
  end
end
