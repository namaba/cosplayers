class Creater::PhotosController < ApplicationController
  before_action :set_photo, only: %i[edit update destroy]

  def edit

  end

  def update
    if @photo.update(photo_params)
      redirect_to @photo, notice: '更新しました'
    else
      flash.now[:alert] = '更新に失敗しました'
      render :edit
    end
  end

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

  def photo_params
    params.require(:photo).permit(
      :id,
      :work_id,
      :description,
      :photo_image,
    )
  end
end