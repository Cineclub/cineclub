class ConfirmedUserGuard < Clearance::SignInGuard
  def call
    if !signed_in?
      next_guard
    elsif current_user.email_confirmed_at.present?
      next_guard
    else
      failure 'You must be confirmed to sign in. Please check your e-mail.'
    end
  end
end
