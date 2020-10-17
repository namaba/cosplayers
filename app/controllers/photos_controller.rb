class PhotosController < ApplicationController
  before_action :set_work, only: %i[show]
  before_action :set_creater, only: %i[show]

  def index
    @photos = Photo.includes(:user).page(params[:page]).per(20)
  end

  def show
  end

  private

  def set_work
    @photo = Work.find params[:id]
  end

  def set_creater
    @creater = @photo.creater
  end
end