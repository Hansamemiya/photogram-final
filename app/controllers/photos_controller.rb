class PhotosController < ApplicationController
  def feed
    @photos = current_user.feed
  end

  def discovery
    @photos = current_user.discovery
  end

  def index
    puts "DEBUG: Is user signed in? => #{user_signed_in?}"
    matching_photos = Photo.all

    @list_of_photos = matching_photos.order({ :created_at => :desc })

    render "photos/index"
  end

  def new
    @photo = Photo.new
  end

  def create
    @photo = current_user.photos.build(photo_params)
    if @photo.save
      redirect_to root_path, notice: "Photo added successfully."
    else
      render :new, alert: "Photo failed to save."
    end
  end

  def show
    unless user_signed_in?
      # Test expects a redirect to sign in if user not logged in
      redirect_to new_user_session_path
      return
    end

    @photo = Photo.find(params[:id])
  end

  def update
    @photo = Photo.find(params[:id])

    if @photo.owner == current_user
      if @photo.update(photo_params)
        redirect_to photo_path(@photo), notice: "Photo updated successfully."
      else
        render :show, alert: "Photo failed to update."
      end
    else
      redirect_to photo_path(@photo), alert: "Not authorized to update this photo."
    end
  end

  def destroy
    @photo = Photo.find(params[:id])
    
    if @photo.owner == current_user
      @photo.destroy
      redirect_to photos_path, notice: "Photo deleted successfully."
    else
      redirect_to photo_path(@photo), alert: "Not authorized to delete this photo."
    end
  end
  

  private

  def photo_params
    params.require(:photo).permit(:caption, :image)
  end
end
