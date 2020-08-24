class Creaters::RequestsController < ApplicationController
  before_action :set_creater
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