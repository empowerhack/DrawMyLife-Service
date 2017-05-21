class Organisation < ActiveRecord::Base
  obfuscate_id spin: ENV['OBFUSCATE_ID_SPIN_NUMBER'].to_i
  alias_attribute :dml_id, :to_param

  validates :name, presence: true

  has_many :users
end
