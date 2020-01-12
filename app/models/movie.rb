class Movie < ApplicationRecord
  validates :original_title, presence: true
end
