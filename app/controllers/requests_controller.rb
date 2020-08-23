class RequestsController < ApplicationController
  def new
    @request = current_user.sent_requests.build()
  end

  def create
    @request = current_user.requests.build(request_params)
    @request.status = :requesting
    if @request.save
      redirect_to thank_requests_path, notice: '保存しました'
    else
      flash.now[:alert] = @request.errors.full_messages.join("\n")
      render :new
    end
  end

  def thank
  end

  private
  def request_params
    params.required(:request).permit(
    :artist_id,
      :amount,
      :description,
      :genre,
      :is_anonymous,
      :is_hidden,
    )
  end
end