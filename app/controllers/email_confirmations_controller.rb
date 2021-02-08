class EmailConfirmationsController < ApplicationController
  def edit; end

  def update
    user = User.find_by(email_confirmation_token: params[:token])

    if user.blank?
      redirect_to confirm_email_path(token: params[:token]), alert: 'You e-mail address could not be confirmed.'
      return
    end

    user.confirm_email!
    redirect_to root_path, notice: "Your e-mail address has been confirmed successfully. You're now able to sign in."
  end
end
