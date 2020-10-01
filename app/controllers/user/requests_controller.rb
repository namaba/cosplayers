class User::RequestsController < ApplicationController
  before_action :set_request, only: %i[show]

  def index
    @requests = case params[:status]&.to_sym
                when :making
                  current_user.requests.making.page(params[:page]).per(20)
                when :completed
                  current_user.requests.completed.page(params[:page]).per(20)
                when :canceled
                  current_user.requests.all_canceled.page(params[:page]).per(20)
                else
                  current_user.requests.requesting.page(params[:page]).per(20)
                end
  end

  def show
  end

  private

  def set_request
    @request = Request.find params[:id]
  end
end