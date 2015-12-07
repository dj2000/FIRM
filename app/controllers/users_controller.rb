class UsersController < ApplicationController
  before_action :set_user, only: [:approve, :reject, :change_role]
  def index
    @users = User.all
  end

  def change_role
    @users = User.all
    @user.update(user_params)
  end

  def approve
    binding.pry
    if @user.update(approved: true)
       # send confirmed account email to user
      AdminMailer.account_approval_email(@user).deliver
      redirect_to new_user_session_url
    end
  end

  def reject
    if @user.update(approved: false)
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
