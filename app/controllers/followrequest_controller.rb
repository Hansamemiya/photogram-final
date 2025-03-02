class FollowRequestsController < ApplicationController
  def accept
    request = FollowRequest.find(params[:id])
    request.update(status: "accepted")
    redirect_to user_path(request.recipient)
  end

  def reject
    request = FollowRequest.find(params[:id])
    request.update(status: "rejected")
    redirect_to user_path(request.recipient)
  end
end
