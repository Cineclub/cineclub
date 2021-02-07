class EmailConfirmationsController < ApplicationController
  def update
    user = User.find_by!(email_confirmation_token: params[:token])
    user.confirm_email
    sign_in user
    redirect_to root_path, notice: 'Your e-mail address has been confirmed successfully.'
  end
end
