class CommentsController < ApplicationController
  def create
    unless user_signed_in?
      redirect_to new_user_session_path
      return
    end

    comment = Comment.new
    comment.author_id = current_user.id
    comment.photo_id = params[:photo_id]
    comment.body = params[:body]
    
    if comment.save
      redirect_to "/photos/#{comment.photo_id}"
    else
      redirect_to "/photos/#{comment.photo_id}", alert: "Comment could not be saved."
    end
  end
end
