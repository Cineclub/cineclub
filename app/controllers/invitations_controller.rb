class InvitationsController < ApplicationController
  before_action :set_invitation, only: %i[accept reject]
  before_action :set_team, only: [:create]
  before_action :set_invitee, only: [:create]

  attr_reader :invitation, :team, :invitee

  def create
    invitation = Invitation.new(inviter: current_user, invitee: invitee, team: team)

    if invitation.save
      redirect_to team, notice: 'User was successfully invited to team.'
    else
      redirect_to team, alert: "Couldn't invite user to team."
    end
  end

  def accept
    invitation.accept!
    redirect_to dashboard_path, notice: 'Invitation accepted successfully.'
  end

  def reject
    invitation.reject!
    redirect_to dashboard_path, notice: 'Invitation declined successfully.'
  end

  private

  def set_invitation
    @invitation = Invitation.find(params[:invitation_id])
  end

  def set_team
    @team = Team.find(params[:team_id])
  end

  def set_invitee
    @invitee = User.find_by!(email: params[:invitee_email])
  end
end
