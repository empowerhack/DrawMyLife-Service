require 'carrierwave/test/matchers'
require 'rails_helper'
require 'spec_helper'

describe ImageUploader do
  include CarrierWave::Test::Matchers
  image_src = File.join(Rails.root, "/spec/support/factories/sloth.jpg")
  src_file = File.new(image_src)

  drawing = Drawing.new(image: src_file)

  uploader = ImageUploader.new(drawing, :image)

  before do
    ImageUploader.enable_processing = true
    uploader.store!(drawing.image)
  end

  after do
    ImageUploader.enable_processing = false
    uploader.remove!
  end

  context 'the thumb version' do
    xit "scales down animage to be exactly 100 by 100 pixels" do
      expect(uploader.thumb.transformation[:width]).to eq 100
      expect(uploader.thumb.transformation[:height]).to eq 100
    end
  end

  context 'the small version' do
    xit "scales down a landscape image to be 640 by 640 pixels" do
      expect(uploader.medium.transformation[:width]).to eq 640
      expect(uploader.medium.transformation[:height]).to eq 640
    end
  end

  xit "has the correct format" do
    expect(uploader.format).to eq('jpg')
  end
end
