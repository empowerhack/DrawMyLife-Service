class Organisation < ActiveRecord::Base
  validates :name, presence: true

  has_many :users
end
