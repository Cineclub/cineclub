class Team < ApplicationRecord
  validates :name, length: { minimum: 4, maximum: 50 }
  validates :round_duration, numericality: { only_integer: true, greater_than: 0 }
end
