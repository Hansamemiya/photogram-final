class LikesController < ApplicationController
  def create
    @like = current_user.likes.build(photo_id: params[:photo_id])
    if @like.save
      redirect_to "/photos/#{@like.photo_id}", notice: "Like created successfully"
    else
      redirect_to "/photos/#{@like.photo_id}", alert: "Like failed."
    end
  end

  def destroy
    like = Like.find(params[:id])
    if like.fan_id == current_user.id
      like.destroy
      redirect_to "/photos/#{like.photo_id}", alert: "Like deleted successfully"
    else
      redirect_to root_path, alert: "Not authorized to unlike."
    end
  end
end
