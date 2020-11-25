class Creater::WorksController < ApplicationController
  before_action :set_work, only: %i[show edit update]

  def new
    @work = current_user.creater.works.build
    @work.photos.build
  end

  def create
    @work = if params[:work][:request_id]
      @request = Request.find params[:work][:request_id]
      @request.build_work(work_params)
    else
      current_user.creater.works.build(work_params)
    end


    if @work.save
      back_path = @work.request ? creater_request_path(current_user.creater.id, @work.request) : creater_path(current_user.creater)
      redirect_to back_path, notice: '投稿しました'
    else
      flash.now[:alert] = '投稿に失敗しました'
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
    @work.attributes = work_params
    if @work.save
      back_path = @work.request ? creater_request_path(current_user.creater.id, @work.request) : creater_path(current_user.creater)
      redirect_to back_path, notice: '更新しました'
    else
      flash.now[:alert] = '失敗しました'
      render :edit
    end
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