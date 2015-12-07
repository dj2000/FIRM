class AdminMailer < ActionMailer::Base
  default from: "admin@example.com"

  def new_user_waiting_for_approval(user)
    @user = user
    admin_email = User.where(role_id: Role.where(name: "super_admin")).first.email
    mail(to: admin_email, subject: 'New user waiting for Approval')
  end

  def account_approval_email(user)
    @user = user
    mail(to: @user.email, subject: 'Your Account is Confirmed')
  end
end
