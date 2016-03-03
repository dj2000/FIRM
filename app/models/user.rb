class User < ActiveRecord::Base
	include TheRole::Api::User
	# Include default devise modules. Others available are:
	# :confirmable, :lockable, :timeoutable and :omniauthable
	devise :database_authenticatable, :registerable,
				 :recoverable, :rememberable, :trackable, :validatable

	validates :first_name, :last_name, presence: true
	after_create :send_admin_mail, unless: "skip_password_validation.present?"
	after_initialize :generate_random_password, if: "skip_password_validation.present?"
	after_create :send_credentials
	after_update :send_password_change_email, if: :needs_password_change_email?

	attr_accessor :skip_password_validation, :current_user_mail

	USER_STATUS = ['Approved', 'Rejected']

	default_scope { order('created_at asc') }
	scope :pending, -> { where(status: 'Pending') }
	scope :approved, -> { where(status: 'Approved') }
	scope :rejected, -> { where(status: 'Rejected') }
	scope :except_admin_role, -> { where("role_id is ? OR role_id in (?)", nil, Role.get_role.map(&:id)) }

	def send_admin_mail
		AdminMailer.new_user_waiting_for_approval(self).deliver
	end

	def send_credentials
		AdminMailer.send_credentials(current_user_mail, self).deliver if self.skip_password_validation == true
	end

	def generate_random_password
		self.password =  Devise.friendly_token.first(8)
	end

	def name
		"#{self.try(:first_name)} #{self.try(:last_name)}"
	end

	def active_for_authentication?
		super && status == "Approved"
	end

	def inactive_message
		if status == "Pending" || status == "Rejected"
			:not_approved
		else
			super # Use whatever other message
		end
	end

	def needs_password_change_email?
    encrypted_password_changed? && persisted?
  end

  def send_password_change_email
    UserMailer.password_changed(self, current_user_mail, password).deliver if current_user_mail
  end
end
