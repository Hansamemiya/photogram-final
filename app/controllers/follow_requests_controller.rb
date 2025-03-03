class FollowRequestsController < ApplicationController
  def create
    unless user_signed_in?
      redirect_to new_user_session_path and return
    end

    # Reading `recipient_id` from form
    recipient = User.find(params[:recipient_id])
    new_request = FollowRequest.new
    new_request.sender_id = current_user.id
    new_request.recipient_id = recipient.id

    # If user is private => pending, else accepted
    if recipient.private?
      new_request.status = "pending"
    else
      new_request.status = "accepted"
    end

    if new_request.save
      redirect_to "/users", notice: "Follow request created."
    else
      redirect_to "/users", alert: new_request.errors.full_messages.to_sentence
    end
  end

  def destroy
    # Also used for "Cancel" or "Unfollow"
    request_to_destroy = FollowRequest.find(params[:id])

    # Only sender can delete their request, or a user can unfollow
    if request_to_destroy.sender == current_user
      request_to_destroy.destroy
      redirect_to "/users", notice: "Follow request removed."
    else
      redirect_to "/users", alert: "Not authorized."
    end
  end
end
