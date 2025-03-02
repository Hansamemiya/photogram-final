class LikesController < ApplicationController
  before_action :authenticate_user!

  def create
    @like = current_user.likes.build(photo_id: params[:photo_id])
    if @like.save
      redirect_to photos_path, notice: "You liked a photo!"
    else
      redirect_to photos_path, alert: "Unable to like the photo."
    end
  end

  def destroy
    @like = Like.find_by(photo_id: params[:photo_id], fan_id: current_user.id)
    if @like
      @like.destroy
      redirect_to photos_path, alert: "You unliked a photo."
    else
      redirect_to photos_path, alert: "Unable to unlike."
    end
  end
end
