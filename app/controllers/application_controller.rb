class ApplicationController < ActionController::Base
  include TheRole::Controller
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :authenticate_user!

  WillPaginate.per_page = 10

  def cities
    state = params[:state]
    @cities = CS.cities(state.to_sym, :us)
    render json: @cities
  end

  def the_role_default_access_denied_response
    access_denied_msg = t(:access_denied, scope: :the_role)
    if request.xhr?
      render json: {
        errors: { the_role: [ access_denied_msg ] },

        controller_name:      controller_path,
        action_name:          action_name,
        has_access_to_action: current_user.try(:has_role?, controller_path, action_name),

        current_user: { id: current_user.try(:id) },

        owner_check_object: {
          owner_check_object_id:    @owner_check_object.try(:id),
          owner_check_object_class: @owner_check_object.try(:class).try(:to_s)
        },

        has_access_to_object: current_user.try(:owner?, @owner_check_object)
      }, status: 401
    else
      redirect_to root_path, notice: { error: access_denied_msg }
    end
  end
end
