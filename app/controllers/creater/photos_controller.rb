class Creater::PhotosController < ApplicationController
  before_action :set_photo, only: %i[destroy]

  def destroy
    if @photo.destroy
      redirect_to creater_path(current_user.creater), notice: '作品を削除しました'
    else
      flash.now[:alert] = '削除に失敗しました'
      render @photo
    end
  end

  private

  def set_photo
    @photo = Photo.find params[:id]
  end
end