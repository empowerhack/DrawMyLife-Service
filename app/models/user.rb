class User < ActiveRecord::Base
  enum role: %i(admin org_admin super_admin)

  validates :role, presence: true
  validates :email, presence: true, length: { minimum: 4, maximum: 60 }
  validates :country, presence: true

  devise :database_authenticatable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable

  belongs_to :organisation
  has_many :drawings, dependent: :destroy

  scope :active, -> { where(deleted_at: nil) }

  def soft_delete
    update_attribute(:deleted_at, Time.current)
  end

  def active_for_authentication?
    super && !deleted_at
  end

  def inactive_message
    !deleted_at ? super : :deleted_account
  end

  def password_required?
    # Password is required if it is being set, but not for new records
    if persisted?
      password.present? || password_confirmation.present?
    else
      false
    end
  end

    # new function to set the password without knowing the current
  # password used in our confirmation controller.
  def attempt_set_password(params)
    p = {}
    p[:password] = params[:password]
    p[:password_confirmation] = params[:password_confirmation]
    update_attributes(p)
  end

  # new function to return whether a password has been set
  def has_no_password?
    self.encrypted_password.blank?
  end

  # Devise::Models:unless_confirmed` method doesn't exist in Devise 2.0.0 anymore.
  # Instead you should use `pending_any_confirmation`.
  def only_if_unconfirmed
    pending_any_confirmation {yield}
  end
end
