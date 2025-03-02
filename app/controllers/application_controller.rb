class ApplicationController < ActionController::Base

  def load_current_user
    the_id = session[:user_id]
    @current_user = User.where({ :id => the_id }).first
  end
  
  helper_method :current_user, :user_signed_in?

  def current_user
    @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
  end

  def user_signed_in?
    current_user.present?
  end
end
