class User < ActiveRecord::Base
  enum role: %i(admin org_admin super_admin)

  validates :role, presence: true
  validates :email, presence: true, length: { minimum: 4, maximum: 60 }
  validates :country, presence: true
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
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
end
