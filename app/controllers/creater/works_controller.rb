class Creater::WorksController < ApplicationController
  before_action :set_work, only: %i[show]
  def new
    @work = current_user.creater.works.build
    @work.photos.build
  end

  def create
    @work = current_user.creater.works.build(work_params)

    if @work.save
      redirect_to creater_path(current_user.creater), notice: '投稿しました'
    else
      flash.now[:alert] = '投稿に失敗しました'
      render :new
    end
  end

  def show
  end

  private

  def set_work
    @work = Work.find params[:id]
  end

  def work_params
    params.required(:work).permit(
      :creater_id,
      :is_published,
      photos_attributes: [:id, :work_id, :description, :photo_image, :_destroy]
    )
  end
end