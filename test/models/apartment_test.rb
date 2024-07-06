# == Schema Information
#
# Table name: apartments
#
#  id                 :bigint           not null, primary key
#  owner_id           :bigint           not null
#  location           :string           default(""), not null
#  title              :string           default(""), not null
#  amenities          :text             default(""), not null
#  number_of_bedrooms :integer          default(0), not null
#  rent_amount        :integer          default(0), not null
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#
require "test_helper"

class ApartmentTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
