class UsersController < ApplicationController

  def show
  end

  def new
  end

  def create
    user = User.new(user_params)
    if user.save
      session[:user_id] = user.id
      flash[:notice] = "Is that seriously your email? Account created"
      redirect_to dashboard_path
    else
      flash[:notice] = "We sunk your Battleship. Unable to create user account"
      render :new
    end
  end

  private

    def user_params
      params.permit(:name, :email, :password, :password_confirmation)
    end

end
