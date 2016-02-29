class UsersController < ApplicationController
  before_action :set_user, only: [:update, :change_status]
  before_action :all_users
  def index
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to users_path
    else
      render action: :new
    end
  end

  def update
    @user = User.find_by_id(params[:id])
    if (@user == current_user)
      @user.is_active = true
    end
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
    params[:user][:status] = params["user_#{params[:id]}"][:status] if params[:id].present?
    unless params[:id].present?
      params[:user][:skip_password_validation] = true
      params[:user][:status] = "Approved"
      params[:user][:current_user_mail] = current_user.email
    end
    params.require(:user).permit(:role_id, :status, :first_name, :last_name, :email, :current_user_mail, :skip_password_validation, :is_active)
  end
end
