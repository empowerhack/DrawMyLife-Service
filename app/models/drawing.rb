class Drawing < ActiveRecord::Base
  enum status: %i(pending complete)
  enum gender: %i(not_specified female male other)

  validates :image, presence: true
  validates :status, presence: true

  with_options if: :complete? do |complete|
    complete.validates :description, presence: true
    complete.validates :subject_matter, presence: true
    complete.validates :mood_rating, presence: true
    complete.validates :country, presence: true
  end

  validates :age, numericality: { only_integer: true }, allow_nil: true
  validates :mood_rating, numericality: { only_integer: true, greater_than_or_equal_to: 1, less_than_or_equal_to: 10 }, allow_nil: true

  has_attached_file :image, styles: {
    medium: ["640x", :jpg],
    thumb: ["100x100#", :jpg],
    large: ["100%", :jpg]
  }, convert_options: {
    all: "-bordercolor none -border 1 -trim"
  }

  validates_attachment_content_type :image, content_type: %r{\A(image\/(jpeg|png|gif|tiff|bmp)|application\/pdf)\z},
                                            message: "Accepted image formats are: jpg/jpeg, png, tiff, gif, bmp, pdf"

  belongs_to :user

  scope :desc, -> { order("drawings.created_at DESC") }

  def viewer_can_change?(viewer)
    viewer.organisation == user.organisation
  end
end
