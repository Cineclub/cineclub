class User < ApplicationRecord
  include Clearance::User

  belongs_to :country, optional: true
  has_many :memberships
  has_many :rounds
  has_many :teams, through: :memberships
  validates :first_name, presence: true

  def member_of?(team)
    memberships.exists?(team: team)
  end
end
