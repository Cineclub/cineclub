class Invitation < ApplicationRecord
  belongs_to :invitee, class_name: 'User'
  belongs_to :inviter, class_name: 'User'
  belongs_to :team

  validates :invitee, uniqueness: { scope: %i[team accepted] }, unless: :accepted?
  validate :invitee_not_in_team, on: :create

  private

  def invitee_not_in_team
    errors.add(:invitee, 'already belongs to the team') if invitee.member_of?(team)
  end
end
