class UsersController < ApplicationController
  before_action :set_user, only: [:update, :change_status]
  before_action :all_users
  def index
  end

  def update
    @user = User.find_by_id(params[:id])
    @user.update(user_params)
    all_users
    respond_to do |format|
      format.js
    end
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

  def all_users
    @pending_users = User.pending
    @approved_users = User.approved
    @rejected_users = User.rejected
  end

  def user_params
    params.require(:user).permit(:role_id, :status)
  end
end
