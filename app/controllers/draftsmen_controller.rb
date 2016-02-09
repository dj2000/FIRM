class DraftsmenController < ApplicationController
  before_action :set_draftsman, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @draftsmen = Draftsman.all.paginate(page: params[:page])
    respond_with(@draftsmen)
  end

  def show
    respond_with(@draftsman)
  end

  def new
    @draftsman = Draftsman.new
    respond_with(@draftsman)
  end

  def edit
  end

  def create
    @draftsman = Draftsman.new(draftsman_params)
    @draftsman.save
    respond_with(@draftsman)
  end

  def update
    @draftsman.update(draftsman_params)
    respond_with(@draftsman)
  end

  def destroy
    @draftsman.destroy
    respond_with(@draftsman)
  end

  private
    def set_draftsman
      @draftsman = Draftsman.find(params[:id])
    end

    def draftsman_params
      params.require(:draftsman).permit(:first_name, :last_name, :middle_initial, :email)
    end
end
