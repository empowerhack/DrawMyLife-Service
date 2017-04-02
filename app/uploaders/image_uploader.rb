class ImageUploader < CarrierWave::Uploader::Base
  include Cloudinary::CarrierWave
  # Include RMagick or MiniMagick support:
  # include CarrierWave::RMagick
  include CarrierWave::MiniMagick
  process :set_content_type, :set_file_size, :set_updated_at

  # Choose what kind of storage to use for this uploader:
  #  storage :file
  # storage :fog
  if Rails.env.test?
    CarrierWave.configure do |config|
      config.storage = :file
      config.enable_processing = false
    end
  end
  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  def set_content_type
    model.image_content_type = file.content_type if file.content_type
  end

  def set_file_size
    model.image_file_size = file.size
  end

  def set_updated_at
    model.image_updated_at = Time.now
  end

  # Provide a default URL as a default if there hasn't been a file uploaded:
  # def default_url
  #   # For Rails 3.1+ asset pipeline compatibility:
  #   # ActionController::Base.helpers.asset_path("fallback/" + [version_name, "default.png"].compact.join('_'))
  #
  #   "/images/fallback/" + [version_name, "default.png"].compact.join('_')
  # end

  # Process files as they are uploaded:
  # process scale: [200, 300]
  #
  # def scale(width, height)
  #   # do something
  # end

  # convert_options: {
  #   all: "-bordercolor none -border 1 -trim"

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

  # Override the filename of the uploaded files:
  # Avoid using model.id or version_name here, see uploader/store.rb for details.
  # def filename
  #   "something.jpg" if original_filename
  # end
end
