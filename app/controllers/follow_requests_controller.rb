class FollowRequestsController < ApplicationController
  def create
    unless user_signed_in?
      redirect_to new_user_session_path and return
    end
  
    recipient = User.find(params[:recipient_id])
    new_request = FollowRequest.new
    new_request.sender_id = current_user.id
    new_request.recipient_id = recipient.id
    new_request.status = recipient.private? ? "pending" : "accepted"
  
    if new_request.save
      redirect_to "/users", notice: "Follow request created."
    else
      redirect_to "/users", alert: new_request.errors.full_messages.to_sentence
    end
  end
  

  def destroy
    request = FollowRequest.find(params[:id])
    if request.sender_id == current_user.id
      request.destroy
      redirect_to "/users", notice: "Follow request removed."
    else
      redirect_to "/users", alert: "Not authorized."
    end
  end
  
end
