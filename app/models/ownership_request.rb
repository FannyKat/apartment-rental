# == Schema Information
#
# Table name: ownership_requests
#
#  id         :bigint           not null, primary key
#  tenant_id  :bigint           not null
#  status     :string           default("pending"), not null
#  email      :string           default(""), not null
#  first_name :string           default(""), not null
#  last_name  :string           default(""), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class OwnershipRequest < ApplicationRecord
  belongs_to :tenant, class_name: 'User'

  has_one_attached :cin

  # Validations
  validates :email, :first_name, :last_name, :cin, presence: true

  after_update :grant_ownership, if: :accepted?

  def accepted?
    status == 'accepted'
  end

  def self.is_requested?(user)
    latest_request = OwnershipRequest.where(tenant_id: user.id).order(created_at: :desc).first

    accepted_request_exists = OwnershipRequest.exists?(tenant_id: user.id, status: 'accepted')

    if accepted_request_exists
      "accepted"
    elsif latest_request
      latest_request.status
    else
      "Pas de demande en cours."
    end
  end

  private

  def grant_ownership
    tenant.update(role: 'owner') if accepted?
  end
end
