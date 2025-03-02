class UsersController < ApplicationController
  def index
    matching_users = User.all

    @list_of_users = matching_users.order({ :username => :asc})
    render "users/index"
  end

  def show
    the_username = params.fetch("path_id")
  
    @the_user = User.where({ :username => the_username}).at(0)
  
    user_photos = @the_user.photos
  
    @list_of_photos = user_photos.order({ :created_at => :desc })

    render "users/show"
  end
end
