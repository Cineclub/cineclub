Clearance.configure do |config|
  config.mailer_sender = "no-reply@cineclub.app"
  config.rotate_csrf_on_sign_in = true
  config.routes = true
  config.sign_in_guards = [ConfirmedUserGuard]
end
