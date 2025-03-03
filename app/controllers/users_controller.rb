class UsersController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show]

  def index
    @list_of_users = User.order(username: :asc)
    render "users/index"
  end

  def show
    the_username = params[:id]
    @the_user = User.find_by(username: the_username)

    if @the_user.nil?
      redirect_to users_path, alert: "User not found."
    else
      @list_of_photos = @the_user.photos.order(created_at: :desc)
      render "users/show"
    end
  end
end
