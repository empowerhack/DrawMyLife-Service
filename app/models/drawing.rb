class Drawing < ActiveRecord::Base
  validates :image, presence: true
  validates :age, presence: true
  validates :gender, presence: true
  validates :subject_matter, presence: true
  validates :mood_rating, presence: true

  has_attached_file :image, styles: { medium: "640x" }
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/

  belongs_to :user

  scope :desc, -> {
    order("drawings.created_at DESC")
  }
end
