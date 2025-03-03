class LikesController < ApplicationController
  def create
    unless user_signed_in?
      redirect_to new_user_session_path
      return
    end
    
    like = current_user.likes.build(photo_id: params[:photo_id])
    if like.save
      redirect_to "/photos/#{like.photo_id}"
    else
      redirect_to "/photos/#{like.photo_id}", alert: "Like failed."
    end
  end

  def destroy
    unless user_signed_in?
      redirect_to new_user_session_path
      return
    end

    like = Like.find(params[:id])
    if like.fan_id == current_user.id
      like.destroy
      redirect_to "/photos/#{like.photo_id}"
    else
      redirect_to root_path, alert: "Not authorized to unlike."
    end
  end
end
