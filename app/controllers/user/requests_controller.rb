class User::RequestsController < ApplicationController
  before_action :set_request, only: %i[show]

  def index
    @requests = case params[:status]&.to_sym
                when :completed
                  current_user.requests.completed.page(params[:page]).per(20)
                when :canceled
                  current_user.requests.all_canceled.page(params[:page]).per(20)
                else
                  current_user.requests.in_progress.page(params[:page]).per(20)
                end
  end

  def show
  end

  private

  def set_request
    @request = Request.find params[:id]
  end
end