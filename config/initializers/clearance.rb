Clearance.configure do |config|
  config.allow_sign_up = true
  config.cookie_domain = "selldome.herokuapp.com"
  config.cookie_expiration = lambda { |cookies| 1.year.from_now.utc }
  config.cookie_name = "remember_token"
  config.cookie_path = "/"
  config.routes = false
  config.httponly = false
  config.mailer_sender = "no-reply@selldome.com"
  config.password_strategy = Clearance::PasswordStrategies::BCrypt
  config.redirect_url = "/"
  config.rotate_csrf_on_sign_in = false
  config.secure_cookie = false
  config.sign_in_guards = []
  config.user_model = User
end
