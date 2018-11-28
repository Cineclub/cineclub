class User < ApplicationRecord
  include Clearance::User

  belongs_to :country, optional: true
  validates :first_name, presence: true
end
