class LikesController < ApplicationController
  before_action :authenticate_user!

  def create
    like = current_user.likes.build(photo_id: params[:photo_id])
    if like.save
      redirect_to root_path, notice: "You liked a photo successfully."
    else
      redirect_to root_path, alert: "Like failed."
    end
  end
  

  def destroy
    like = Like.find_by(id: params[:id])
    if like
      like.destroy
      redirect_to root_path, alert: "You unliked a photo."
    else
      redirect_to root_path, alert: "Unable to unlike."
    end
  end
  