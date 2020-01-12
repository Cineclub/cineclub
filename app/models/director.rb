class Director < ApplicationRecord
  belongs_to :country
  validate :name, presence: true
end
