require 'cloudinary/migrator'

namespace :db do

  task migrate_images: :environment do
    migrator = Cloudinary::Migrator.new(
    :retrieve=>proc{|id| Drawing.find(id) },
    :complete=>proc{|id, result |
                    drawing = Drawing.find(id)
                    puts drawing.image
                    $stderr.print "done #{id} #{result}\n" }
    )

    Drawing.all.each do
      |drawing|
      migrator.process(:id =>  drawing.id, :url => "#{drawing.image.url}")

    end
    migrator.done
  end
end
