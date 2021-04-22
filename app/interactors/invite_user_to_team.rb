require 'hanami/interactor'

class InviteUserTo
  include Hanami::Interactor

  expose :invitation

  def call(inviter:, invitee:, team:)
    @invitation = Invitation.new(
      inviter: inviter,
      invitee: invitee,
      team: team
    )

    @invitation.errors.full_messages.each { |msg| error(msg) } unless @invitation.save
  end
end
