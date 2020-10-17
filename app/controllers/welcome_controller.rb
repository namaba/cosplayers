class WelcomeController < ApplicationController
  def index
    @creaters = Creater.limit(10)
    @photos = Photo.includes(:user).limit(10)
  end
end