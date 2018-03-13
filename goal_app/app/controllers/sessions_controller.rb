class SessionsController < ApplicationController

  before_action :require_user!, only: [:destroy]

  def new
    render :new
  end

  def create
    user = User.find_by_credentials(user_params[:username], user_params[:password])

    unless user.nil?
      sign_in(user)
      redirect_to goals_url
    else
      flash[:errors] = ["Invalid Credentials"]
      render :new
    end
  end

  def destroy
    current_user.reset_session_token!
    session[:session_token] = nil
    redirect_to new_session_url
  end

  private

  def user_params
    params.require(:user).permit(:username, :password)
  end


end
