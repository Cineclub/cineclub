class UsersController < Clearance::UsersController
  private

  def user_params
    params.require(:user).permit(
      :email,
      :first_name,
      :password
    )
  end
end
