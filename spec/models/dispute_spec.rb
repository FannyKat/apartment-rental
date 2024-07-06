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
require 'rails_helper'

RSpec.describe Dispute, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
