class UsersController < ApplicationController
  before_action :set_user, only: [:approve_reject, :change_role]
  def index
    @users = User.all
  end

  def change_role
    @users = User.all
    @user.update(user_params)
  end

  def approve_reject
    approved = params[:approved]
    if @user.update(approved: approved)
       # send confirmed account email to user
      AdminMailer.account_approval_email(@user).deliver
      redirect_to new_user_session_url
    end
  end


  private
  def set_user
    @user = User.find_by_id(params[:id])
  end

  def user_params
    params.require(:user).permit(:role_id, :approved)
  end
end
