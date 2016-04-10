class User < ActiveRecord::Base
  validates :email, presence: true, length: { minimum: 4, maximum: 16 }
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  belongs_to :organisation
  belongs_to :location
  has_many :drawings, dependent: :destroy
end
