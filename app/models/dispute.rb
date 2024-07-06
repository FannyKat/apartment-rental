# == Schema Information
#
# Table name: disputes
#
#  id          :bigint           not null, primary key
#  booking_id  :bigint           not null
#  user_id     :bigint           not null
#  description :text             default(""), not null
#  status      :string           default(""), not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
class Dispute < ApplicationRecord
  belongs_to :booking
  belongs_to :user

  has_one_attached :image
end
