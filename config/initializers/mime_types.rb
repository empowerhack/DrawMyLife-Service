# Be sure to restart your server when you modify this file.

# Add new mime types for use in respond_to blocks:
# Mime::Type.register "text/richtext", :rtf

Mime::Type.register "application/hal+json", :hal
ActionController::Renderers.add :hal do |obj, _|
  self.content_type ||= Mime[:hal]
  obj
end
