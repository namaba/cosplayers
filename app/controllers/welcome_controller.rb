class WelcomeController < ApplicationController
  def index
    @creaters = Creater.limit(12)
  end
end