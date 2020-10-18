class PhotosController < ApplicationController
  before_action :set_photo, only: %i[show destroy]
  before_action :set_creater, only: %i[show destroy]

  def index
    @photos = Photo.includes(:user).page(params[:page]).per(20)
  end

  def show
  end

  private

  def set_photo
    @photo = Photo.find params[:id]
  end

  def set_creater
    @creater = @photo.creater
  end
end