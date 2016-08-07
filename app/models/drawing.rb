class Drawing < ActiveRecord::Base
  enum status: %i(pending complete)

  validates :image, presence: true
  validates :age, presence: true, numericality: { only_integer: true }
  validates :gender, presence: true
  validates :subject_matter, presence: true
  validates :mood_rating, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 1, less_than_or_equal_to: 10 }
  validates :status, presence: true

  has_attached_file :image, styles: { medium: "640x" }
  validates_attachment_content_type :image, content_type: %r{\Aimage\/.*\Z}

  belongs_to :user

  scope :desc, -> { order("drawings.created_at DESC") }
end
