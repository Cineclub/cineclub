class Team < ApplicationRecord
  has_many :invitations, dependent: :destroy
  has_many :memberships, dependent: :destroy
  has_many :rounds, dependent: :destroy
  has_many :users, through: :memberships
  validates :name, uniqueness: { case_sensitive: false }, presence: true, length: { minimum: 5, maximum: 40 }

  delegate :empty?, to: :users

  def current_round
    rounds.order(:index_in_team).last
  end
end
