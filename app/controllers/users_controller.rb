class UsersController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index]

  def show
    @user = User.find(params[:id])
    @pending_follow_requests = @user.received_follow_requests.where(status: "pending")
  end
  
  def edit
    @user = current_user
  end

  def update
    @user = current_user
    if @user.update(user_params)
      redirect_to root_path, notice: "Profile updated successfully."
    else
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:username, :email, :password, :password_confirmation)
  end
end
