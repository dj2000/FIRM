class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :authenticate_user!

  WillPaginate.per_page = 5

  def cities
    state = params[:state]
    @cities = CS.cities(state.to_sym, :us)
    render json: @cities
  end
end
