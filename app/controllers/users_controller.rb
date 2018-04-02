class UsersController < ApplicationController

  def show
  end

  def create
    user = User.new(user_params)
    if user.save
      session[:user_id] = user.id
      UserMailer.activation_invite(user).deliver_now
      flash[:notice] = "Account created. Please check your email to activate your account."
      redirect_to dashboard_path
    else
      flash[:notice] = "We sunk your Battleship. Unable to create user account"
      redirect_to root_path
    end
  end

  private

    def user_params
      params.permit(:name, :email, :password, :password_confirmation)
    end

end
