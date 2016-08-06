class User < ActiveRecord::Base
  validates :email, presence: true, length: { minimum: 4, maximum: 60 }
  validates :country, presence: true
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  belongs_to :organisation
  has_many :drawings, dependent: :destroy
end
