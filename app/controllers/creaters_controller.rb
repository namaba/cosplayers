class CreatersController < ApplicationController
  def index
  end

  def show
    @creater = Creater.includes(:user).find params[:id]
  end
end