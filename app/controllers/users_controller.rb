class UsersController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show]

  def index
    @list_of_users = User.order(username: :asc)
    render "users/index"
  end

  def show
    @the_user = User.find_by(username: params[:username])
    if @the_user.nil?
      redirect_to users_path, alert: "User not found."
    else
      @list_of_photos = @the_user.photos.order(created_at: :desc)
      render "users/show"
    end
  end

  def feed
    # Must be signed in to see feed
    unless user_signed_in?
      redirect_to new_user_session_path and return
    end

    @the_user = User.find_by(username: params[:username])
    if @the_user.nil?
      redirect_to users_path, alert: "User not found."
    else
      # The test expects to see photos of people @the_user is following
      @photos = Photo.where(owner_id: @the_user.following).order(created_at: :desc)
      render "users/feed"
    end
  end

  def liked_photos
    unless user_signed_in?
      redirect_to new_user_session_path and return
    end

    @the_user = User.find_by(username: params[:username])
    if @the_user.nil?
      redirect_to users_path, alert: "User not found."
    else
      # The test expects photos that @the_user has liked
      @photos = Photo.joins(:likes).where(likes: { fan_id: @the_user.id }).distinct.order(created_at: :desc)
      render "users/liked_photos"
    end
  end

  def discover
    unless user_signed_in?
      redirect_to new_user_session_path and return
    end

    @the_user = User.find_by(username: params[:username])
    if @the_user.nil?
      redirect_to users_path, alert: "User not found."
    else
      # Photos liked by the people @the_user is following
      @photos = Photo
        .joins(:likes)
        .where(likes: { fan_id: @the_user.following })
        .distinct
        .order(created_at: :desc)

      render "users/discover"
    end
  end
end
