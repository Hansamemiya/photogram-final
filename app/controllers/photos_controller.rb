class PhotosController < ApplicationController
  def feed
    @photos = current_user.feed
  end

  def discovery
    @photos = current_user.discovery
  end

  def index
    @photos = Photo.all.order(created_at: :desc)
  end

  def new
    @photo = Photo.new
  end

  def create
    @photo = current_user.photos.build(photo_params)
    if @photo.save
      redirect_to photos_path, notice: "Photo added successfully."
    else
      render :new
    end
  end

  private

  def photo_params
    params.require(:photo).permit(:caption, :image)
  end
end
