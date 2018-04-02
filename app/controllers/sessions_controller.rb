class SessionsController < ApplicationController

  def create
    if user = User.find_by(email: params[:email])
      session[:user_id] = user.id
      flash[:notice] = "Welcome #{user.name}!"
      redirect_to dashboard_path
    else
      flash[:error] = "Miss! Invalid Credentials"
      redirect_to login_path
    end
  end

  def destroy
    session.destroy
    @current_user = nil
    flash[:notice] = "Successfully logged out"
    redirect_to root_path
  end

end
