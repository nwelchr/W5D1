class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  helper_method :current_user, :signed_in?

  def current_user
    User.find_by_session_token(session[:session_token])
  end

  def signed_in?
    !!current_user
  end

  def require_user!
    unless signed_in?
      redirect_to new_session_url
    end
  end

  def sign_in(user)
    session[:session_token] = user.reset_session_token!
  end

end
