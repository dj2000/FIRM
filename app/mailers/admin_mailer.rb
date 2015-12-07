class AdminMailer < ActionMailer::Base
  default from: "admin@example.com"

  def new_user_waiting_for_approval(user)
    @user = user
    admin_email = User.where(role_id: Role.where(name: "super_admin")).try(:first).try(:email)
    mail(to: admin_email, subject: 'New user waiting for Approval') if admin_email.present?
  end

  def account_approval_email(user)
    @user = user
    admin_email = User.where(role_id: Role.where(name: "super_admin")).try(:first).try(:email)
    mail(from: admin_email, to: @user.email, subject: 'Account Confirmation') if admin_email.present?
  end
end
