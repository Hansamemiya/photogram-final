class FollowRequestsController < ApplicationController
  before_action :authenticate_user!, only: [:create, :update, :destroy]

  def index
    @list_of_follow_requests = FollowRequest.order(created_at: :desc)
    render "follow_requests/index"
  end

  def show
    the_id = params[:id]
    @the_follow_request = FollowRequest.find_by(id: the_id)

    if @the_follow_request.nil?
      redirect_to follow_requests_path, alert: "Follow request not found."
    else
      render "follow_requests/show"
    end
  end

  def create
    recipient = User.find_by(id: params[:query_recipient_id])

    if recipient.nil?
      redirect_to users_path, alert: "User not found."
      return
    end

    existing_request = FollowRequest.find_by(sender_id: current_user.id, recipient_id: recipient.id)
    if existing_request
      redirect_to users_path, alert: "You have already sent a follow request to this user."
      return
    end

    the_follow_request = FollowRequest.new
    the_follow_request.recipient_id = recipient.id
    the_follow_request.sender_id = current_user.id
    the_follow_request.status = recipient.private ? "pending" : "accepted"

    if the_follow_request.save
      redirect_to users_path, notice: "Follow request sent successfully."
    else
      redirect_to users_path, alert: the_follow_request.errors.full_messages.to_sentence
    end
  end

  def update
    the_id = params[:id]
    the_follow_request = FollowRequest.find_by(id: the_id)

    if the_follow_request.nil?
      redirect_to follow_requests_path, alert: "Follow request not found."
      return
    end

    the_follow_request.status = params[:query_status]

    if the_follow_request.save
      redirect_to follow_requests_path, notice: "Follow request updated successfully."
    else
      redirect_to follow_requests_path, alert: the_follow_request.errors.full_messages.to_sentence
    end
  end

  def destroy
    the_id = params[:id]
    the_follow_request = FollowRequest.find_by(id: the_id)

    if the_follow_request.nil?
      redirect_to follow_requests_path, alert: "Follow request not found."
      return
    end

    the_follow_request.destroy
    redirect_to users_path, notice: "Follow request deleted successfully."
  end
end
