# == Schema Information
#
# Table name: disputes
#
#  id          :bigint           not null, primary key
#  booking_id  :bigint           not null
#  owner_id    :bigint           not null
#  tenant_id   :bigint           not null
#  description :text             default(""), not null
#  status      :string           default(""), not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
class Dispute < ApplicationRecord
  belongs_to :booking

  belongs_to :owner, class_name: 'User'
  belongs_to :tenant, class_name: 'User'


  has_one_attached :dispute_image

  # Validations
  validates :description, presence: true
end
