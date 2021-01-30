class Screening < ApplicationRecord
  belongs_to :user
  belongs_to :round

  validates :user, uniqueness: { scope: :round_id }
end
