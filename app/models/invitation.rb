class Invitation < ApplicationRecord
  belongs_to :invitee, class_name: 'User'
  belongs_to :inviter, class_name: 'User'
  belongs_to :team

  validates :invitee, uniqueness: { scope: [:inviter, :team, :accepted] }, unless: :accepted?
end
