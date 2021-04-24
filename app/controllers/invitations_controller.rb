class InvitationsController < ApplicationController
  before_action :set_invitation

  attr_reader :invitation

  def accept
    invitation.accept!
    redirect_to dashboard_path, notice: 'Invitation accepted successfully.'
  end

  def reject
    invitation.reject!
    redirect_to dashboard_path, notice: 'Invitation declined successfully.'
  end

  def set_invitation
    @invitation = Invitation.find(params[:invitation_id])
  end
end
