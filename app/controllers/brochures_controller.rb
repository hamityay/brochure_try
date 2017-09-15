class BrochuresController < ApplicationController

  def new
    @brochure = Brochure.new
  end

  def create
    @brochure = Brochure.new(params.require(:brochure).permit(:title, :file))
    @brochure.save
    redirect_to @brochure
  end

  def index

  end

  def show
    @brochure = Brochure.find params[:id]
  end

  def destroy
    @brochure = Brochure.find params[:id]
    @brochure.destroy
    redirect_to root_path
  end
end
