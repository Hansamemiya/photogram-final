class PhotosController < ApplicationController
  def feed
    @photos = current_user.feed
  end

  def discovery
    @photos = current_user.discovery
  end

  def index
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
  

  private

  def photo_params
    params.require(:photo).permit(:caption, :image)
  end
end
