class AdminMailer < ActionMailer::Base
  default from: "admin@example.com"

  def new_user_waiting_for_approval(user)
    @user = user
    admin_emails = User.where(role_id: Role.where(name: "admin")).try(:map, &:email).compact
    mail(to: admin_emails, subject: 'New user waiting for Approval', from: user.try(:email)) if admin_emails.present?
  end

  def send_credentials(current_user_email, user)
    @current_user_email = current_user_email
    @user = user
    mail(to: @user.try(:email), from: current_user_email, subject: "Welcome Email to New Users")
  end

  def account_approval_email(user, current_user_email)
    @user = user
    mail(from: current_user_email, to: @user.email, subject: 'Account Confirmation') if current_user_email.present?
  end
end
