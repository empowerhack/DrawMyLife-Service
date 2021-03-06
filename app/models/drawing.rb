class Drawing < ActiveRecord::Base
  ### Constants
  STAGES_OF_JOURNEY = ["At home", "In temporary shelter", "Awaiting transit", "On the move", "Arrived at destination"].freeze
  SUBJECT_MATTERS = ["Home / Country of origin", "In transit", "Camp life", "Future hopes / destination"].freeze

  ### Aliases / delegations / overrides
  obfuscate_id spin: ENV['OBFUSCATE_ID_SPIN_NUMBER'].to_i
  alias_attribute :dml_id, :to_param

  alias_attribute :country_code_drawn, :country
  alias_attribute :country_code_home, :origin_country
  alias_attribute :background_story, :story

  delegate :organisation, to: :user

  ### Enumerables
  enum status: %i(pending complete)
  enum gender: %i(not_specified female male other)

  ### Validations
  validates :image, presence: true
  validates :status, presence: true
  validates_inclusion_of :image_consent, in: [true, false]

  with_options if: :complete? do |complete|
    complete.validates :description, presence: true
    complete.validates :subject_matter, presence: true
    complete.validates :mood_rating, presence: true
    complete.validates :country, presence: true
  end

  validates :age, numericality: { only_integer: true }, allow_nil: true
  validates :mood_rating, numericality: { only_integer: true, greater_than_or_equal_to: 1, less_than_or_equal_to: 5 }, allow_nil: true

  has_attached_file :image, styles: {
    medium: ["640x", :jpg],
    thumb: ["100x100#", :jpg],
    large: ["100%", :jpg]
  }, convert_options: {
    all: "-bordercolor none -border 1 -trim"
  }

  validates_attachment_content_type :image, content_type: %r{\A(image\/(jpeg|png|gif|tiff|bmp)|application\/pdf)\z},
                                            message: "Accepted image formats are: jpg/jpeg, png, tiff, gif, bmp, pdf"

  ### Associations
  belongs_to :user

  ### Scopes
  scope :desc, -> { order("drawings.created_at DESC") }
  scope :consent_given, -> { where(image_consent: true) }
  scope :within_org, lambda { |org_id|
    joins(:user).where("users.organisation_id" => org_id)
  }

  def self.complete_with_consent
    complete.consent_given
  end

  def self.to_csv(hxl: false)
    fields = %w(org country age gender mood_rating description story created_at)

    CSV.generate do |csv|
      csv << fields.map(&:capitalize)
      csv << fields.map { |field| "#" + field } if hxl

      # Only export completed entries
      complete.each do |drawing|
        values = drawing.attributes.values_at(*fields.drop(1))
        csv << values.unshift(drawing.user.organisation.name)
      end
    end
  end

  def self.stages_of_journey
    STAGES_OF_JOURNEY
  end

  def self.subject_matters
    SUBJECT_MATTERS
  end

  def can_view?(current_user)
    super_admin_or_same_org?(current_user)
  end

  def can_modify?(current_user)
    super_admin_or_same_org?(current_user)
  end

  private

  def super_admin_or_same_org?(current_user)
    current_user.super_admin? || current_user.organisation_id == user.organisation_id
  end
end
