FactoryGirl.define do
  factory :drawing do
    image { Rack::Test::UploadedFile.new("#{Rails.root}/spec/support/factories/sloth.jpg", "image/jpeg") }
    description "Description of the content of this drawing"
    gender "other"
    age 10
    mood_rating 4
    stage_of_journey "At home"
    subject_matter "Camp life"
    story "Context of the drawing, e.g. child's back story, cultural notes"
    country "GR"
    status "complete"
    image_consent true
    origin_country "SY"

    user
  end
end
