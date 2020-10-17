class Creaters::WorksController < ApplicationController
  before_action :set_creater

  def new

  end

  private

  def set_creater
    @creater = Creater.includes(:user).find params[:creater_id]
  end
end