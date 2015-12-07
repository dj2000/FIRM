class UsersController < ApplicationController
  before_action :set_user, only: [:update, :change_role]
  def index
    @users = User.where(role_id: Role.where.not(name: ["admin", "super_admin"]))
  end

  def update
    status = params[:status]
    if status.present?
      @user.update(status: status)
      AdminMailer.account_approval_email(@user).deliver
      redirect_to new_user_session_url
    else
      @user.update(user_params)
    end
  end

  private
  def set_user
    @user = User.find_by_id(params[:id])
  end

  def user_params
    params.require(:user).permit(:role_id, :status)
  end
end
