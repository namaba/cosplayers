class Creaters::RequestsController < ApplicationController
  before_action :set_creater

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
    @request = current_user.requests.build()
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

  private
  def set_creater
    @creater = Creater.find params[:creater_id]
  end

  def request_params
    params.required(:request).permit(
      :creater_id,
      :amount,
      :description,
      :genre,
      :is_anonymous,
      :is_hidden,
      )
  end
end