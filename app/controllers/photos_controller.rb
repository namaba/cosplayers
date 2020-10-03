class PhotosController < ApplicationController
  def index
    @photos = Work.photo.page(params[:page]).per(20)
  end

  def show
  end
end