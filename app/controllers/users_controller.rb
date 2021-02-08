class UsersController < Clearance::UsersController
  def create
    @user = user_from_params
    @user.email_confirmation_token = Clearance::Token.new

    if @user.save
      UserMailer.confirmation_email(@user).deliver_now # should be done in a background job when possible
      redirect_to root_path, notice: 'Your account has been created. Please check your e-mail.'
    else
      render template: 'users/new'
    end
  end

  private

  def user_params
    params.require(:user).permit(
      :email,
      :first_name,
      :last_name,
      :password
    )
  end
end
