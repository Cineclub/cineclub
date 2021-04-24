class User < ApplicationRecord
  include Clearance::User

  belongs_to :country, optional: true
  has_many :memberships, dependent: :destroy
  has_many :rounds, dependent: :destroy # this should be nullified
  has_many :teams, through: :memberships
  has_many :screenings, dependent: :destroy
  has_many :received_pending_invitations, -> { pending }, class_name: 'Invitation', foreign_key: 'invitee_id'

  validates :first_name, presence: true

  def member_of?(team)
    memberships.exists?(team: team)
  end

  def full_name
    "#{first_name} #{last_name}"
  end

  def confirm_email!
    update(email_confirmed_at: Time.current)
  end
end
