class UsersController < ApplicationController
  def index

  end

  def create
    user = User.new(user_params)
    if user.save
      sign_in(user)
      redirect_to goals_url
    else
      flash[:errors] = user.errors.full_messages
      render :new
    end
  end

  def new
    render :new
  end

  def edit

  end

  def show

  end

  def update

  end

  def destroy

  end

  private

  def user_params
    params.require(:user).permit(:username, :password)
  end
end
