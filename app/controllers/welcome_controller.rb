class WelcomeController < ApplicationController
  def index
    @creaters = Creater.limit(10)
    @photos = Work.photo.includes(:user).limit(10)
  end
end