class ImageUploader < CarrierWave::Uploader::Base
  include Cloudinary::CarrierWave

  include CarrierWave::MiniMagick

  if Rails.env.test?
    CarrierWave.configure do |config|
      config.storage = :file
      config.enable_processing = false
    end
  end

  process convert: [:jpg]
  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  # Create different versions of your uploaded files:
  version :thumb do
    process resize_to_fit: [100, 100]
    process convert: [:jpg]
  end

  version :medium do
    process resize_to_fit: [640, 640]
    process convert: [:jpg]
  end

  version :large do
    process convert: [:jpg]
  end

  # Add a white list of extensions which are allowed to be uploaded.
  # For images you might use something like this:
  def extension_whitelist
    %w(jpg jpeg gif png tiff gif bmp pdf)
  end
end
