class AdminMailer < ActionMailer::Base
  default from: "admin@example.com"

  def new_user_waiting_for_approval(user)
    @user = user
    mail(to: "admin@example.com", subject: 'New user waiting for Approval')
  end

  def account_approval_email(user)
    @user = user
    mail(to: @user.email, subject: 'Your Account is Confirmed')
  end
end
