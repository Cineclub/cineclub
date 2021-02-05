class ConfirmedUserGuard < Clearance::SignInGuard
  def call
    if user_confirmed?
      next_guard
    else
      failure 'You must be confirmed to sign in. Please check your e-mail.'
    end
  end

  def user_confirmed?
    signed_in? && current_user.email_confirmed_at.present?
  end
end
