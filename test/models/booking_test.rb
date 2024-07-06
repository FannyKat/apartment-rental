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
require "test_helper"

class BookingTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
