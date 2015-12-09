class UsersController < ApplicationController
  before_action :set_user, only: [:update, :change_status]
  def index
    @users = User.where(" role_id IS ? or role_id IN (?) ", nil, Role.get_role.map(&:id))
  end

  def update
    @users = User.where(" role_id IS ? or role_id IN (?) ", nil, Role.get_role.map(&:id))
    @user = User.find_by_id(params[:id])
    @user.update(role_id: params[:role_id], status: params[:status])
  end

  def change_status
   status = params[:status]
    if status.present?
      @user.update(status: status)
      AdminMailer.account_approval_email(@user).deliver
      redirect_to new_user_session_url
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
