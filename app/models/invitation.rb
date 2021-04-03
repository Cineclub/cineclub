class Invitation < ApplicationRecord
  belongs_to :invitee, class_name: 'User'
  belongs_to :inviter, class_name: 'User'
  belongs_to :team

  validates :invitee, uniqueness: { scope: :team, conditions: -> { pending } }, if: :pending?
  validate :invitee_not_in_team, on: :create

  scope :pending, -> { where(dismissed_at: nil) }

  def accept!
    transaction do
      team.users << invitee
      dismiss!
    end
  end

  def reject!
    dismiss!
  end

  def pending?
    dismissed_at.nil?
  end

  private

  def dismiss!
    update!(dismissed_at: Time.current)
  end

  def invitee_not_in_team
    errors.add(:invitee, 'already belongs to the team') if invitee.member_of?(team)
  end
end
