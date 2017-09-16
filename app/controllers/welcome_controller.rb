class WelcomeController < ApplicationController
  def index
    @brochures = Brochure.all
  end
end