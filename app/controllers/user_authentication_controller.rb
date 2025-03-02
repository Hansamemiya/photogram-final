class UserAuthenticationController < ApplicationController
  # Sign Up Form
  def sign_up_form
    @user = User.new
    render "user_authentication/sign_up_form"
  end

  # Create User (Sign Up)
  def create
    @user = User.new(user_params)
    if @user.save
      sign_in(@user)  # Auto-login after sign-up
      redirect_to root_path, notice: "Account created successfully."
    else
      render "user_authentication/sign_up_form", alert: "Error signing up."
    end
  end

  # Sign In Form
  def sign_in_form
    render "user_authentication/sign_in_form"
  end

  # Authenticate & Create Session (Sign In)
  def create_cookie
    user = User.find_by(email: params[:email])
    if user && user.valid_password?(params[:password])
      sign_in(user)
      redirect_to root_path, notice: "Signed in successfully."
    else
      redirect_to user_sign_in_path, alert: "Invalid credentials."
    end
  end

  # Sign Out
  def destroy_cookies
    sign_out(current_user)
    redirect_to root_path, notice: "Signed out successfully."
  end

  # Edit Profile Form
  def edit_profile_form
    render({ :template => "user_authentication/edit_profile.html.erb" })
  end

  # Update User Profile
  def update
    if current_user.update(user_params)
      redirect_to root_path, notice: "Profile updated successfully."
    else
      render "user_authentication/edit_profile_form"
    end
  end

  # Delete Account
  def destroy
    current_user.destroy
    redirect_to root_path, notice: "Your account has been deleted."
  end

  private

  def user_params
    params.require(:user).permit(:username, :email, :password, :password_confirmation, :private)
  end
end
