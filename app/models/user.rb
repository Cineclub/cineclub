class User < ApplicationRecord
  include Clearance::User

  belongs_to :country, optional: true
  has_many :memberships, dependent: :destroy
  has_many :rounds
  has_many :teams, through: :memberships
  has_many :screenings, dependent: :destroy

  validates :first_name, presence: true

  def member_of?(team)
    memberships.exists?(team: team)
  end

  def full_name
    "#{first_name} #{last_name}"
  end
end
