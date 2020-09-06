class Creaters::RequestsController < ApplicationController
  before_action :set_creater
  before_action :set_request, only: %i[show edit update accept decline]

  def index
    @requests = case params[:status]&.to_sym
                when :making
                  @creater.requests.making.page(params[:page]).per(20)
                when :completed
                  @creater.requests.completed.page(params[:page]).per(20)
                when :canceled
                  @creater.requests.all_canceled.page(params[:page]).per(20)
                else
                  @creater.requests.requesting.page(params[:page]).per(20)
                end
  end

  def new
    @request = current_user.requests.build
    @reqeust.works.build
  end

  def create
    @request = current_user.requests.build(request_params.merge(creater: @creater, status: :requesting))

    if @request.save
      redirect_to thank_creater_requests_path, notice: '保存しました'
    else
      flash.now[:alert] = @request.errors.full_messages.join("\n")
      render :new
    end
  end

  def thank
  end

  def show
  end

  def edit
    @request.works.build if @request.works.blank?
  end

  def update
    @request.attributes = request_params

    if @request.save
      redirect_to creater_request_path(@request.creater_id, @request), notice: '保存しました'
    else
      redirect_to creater_request_path(@request.creater_id, @request), notice: @request.errors.full_messages.join("\n")
    end
  end

  def accept
    option = if @request.making!
               { notice: '承認しました' }
             else
               { alert: '承認に失敗しました' }
             end
    redirect_to creater_request_path(@creater, @request), option
  end

  def decline
    option = if @request.declined!
               { notice: '辞退しました' }
             else
               { alert: '辞退に失敗しました' }
             end
    redirect_to creater_request_path(@creater, @request), option
  end

  private

  def set_creater
    @creater = Creater.find params[:creater_id]
  end

  def set_request
    @request = Request.find params[:id]
  end

  def request_params
    params.required(:request).permit(
      :creater_id,
      :amount,
      :description,
      :genre,
      :is_anonymous,
      :is_hidden,
      works_attributes: [:id, :genre, :creater_id, :request_id, :is_premium, :is_published, :photo]
    )
  end
end