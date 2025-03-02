class Users::RegistrationsController < Devise::RegistrationsController
  def new
    super
  end

  def create
    super
  end

  private

  def sign_up_params
    params.require(:user).permit(:email, :password, :password_confirmation, :username, :private)
  end

  def account_update_params
    params.require(:user).permit(:email, :password, :password_confirmation, :current_password, :username, :private)
  end
end
