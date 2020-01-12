class Team < ApplicationRecord
  has_many :memberships
  has_many :rounds
  has_many :users, through: :memberships
  validates :name, presence: true, length: { minimum: 5, maximum: 20 }
end
