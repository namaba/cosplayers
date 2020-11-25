class Creater::WorksController < ApplicationController
  before_action :set_work, only: %i[show]

  def new
    @work = if params[:request_id]
              current_user.creater.works.build(request_id: params[:request_id])
            else
              current_user.creater.works.build
            end
    @work.photos.build
  end

  def create
    @work = current_user.creater.works.build(work_params)

    if @work.save
      back_path =  @work.request ? creater_request_path(current_user.creater.id, @work.request) :  creater_path(current_user.creater)
      redirect_to back_path, notice: '投稿しました'
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