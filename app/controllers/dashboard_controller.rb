class DashboardController < ApplicationController

  def index
    if current_user.nil?
      redirect_to root_path
    elsif current_user.inactive?
      flash[:notice] = "This account has not yet been activated. Please check your email."
    end
  end

end
