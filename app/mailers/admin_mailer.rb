class AdminMailer < ActionMailer::Base
  default from: "admin@example.com"

  def new_user_waiting_for_approval(user)
    @user = user
    admin_email = User.where(role_id: Role.where(name: "super_admin")).try(:first).try(:email)
    mail(to: admin_email, subject: 'New user waiting for Approval') if admin_email.present?
  end

  def send_credentials(current_user_email, user)
    @current_user_email = current_user_email
    @user = user
    mail(to: @user.try(:email), from: current_user_email, subject: "Welcome Email to New Users")
  end

  def account_approval_email(user)
    @user = user
    admin_email = User.where(role_id: Role.where(name: "super_admin")).try(:first).try(:email)
    mail(from: admin_email, to: @user.email, subject: 'Account Confirmation') if admin_email.present?
  end
end
