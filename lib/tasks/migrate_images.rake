require 'cloudinary'
require 'cloudinary/migrator'

namespace :db do

  task migrate_images: :environment do
    migrator = Cloudinary::Migrator.new(
    :retrieve=>proc{|id| Drawing.find(id) },
    :complete=>proc{|id, result |
                    drawing = Drawing.find(id)
                    $stderr.print "done #{id} #{result}\n" }
    )

    Drawing.all.each do
      |drawing|
      file = drawing.image_file_name
      migrator.process(:id =>  drawing.id, :url => "./public#{drawing.image.url[/^(.*?)\.png/]}", :public_id => "#{File.basename(file,File.extname(file))}")

    end
    migrator.done
  end
end
