class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def sign_in_user(user)
    user.expire_token!
    session[:email] = user.email
  end

end
