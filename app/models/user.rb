class User < ActiveRecord::Base
  include TheRole::Api::User
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :first_name, :last_name, presence: true
  after_create :send_admin_mail

  USER_STATUS = ['Approved', 'Rejected']

  default_scope { order('created_at asc') }
  scope :pending, -> { where(status: 'Pending').except_admin_role }
  scope :approved, -> { where(status: 'Approved').except_admin_role }
  scope :rejected, -> { where(status: 'Rejected').except_admin_role }
  scope :except_admin_role, -> { where("role_id is ? OR role_id in (?)", nil, Role.get_role.map(&:id)) }

  def send_admin_mail
    AdminMailer.new_user_waiting_for_approval(self).deliver
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
end
