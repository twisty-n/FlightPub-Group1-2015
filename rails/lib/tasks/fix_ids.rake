require 'active_record/fixtures'

namespace :fix_ids do

    desc "Make all of the ID's of the modified supplied database accurate"
    task :fix_all => :environment do
        Rake::Task["fix_ids:fix_destination"].invoke
    end

    desc "Map desitnation country_id to the correct country"
    task :fix_destination => :environment do
        file = File.join(Rails.root, 'test', 'linker', 'destinations_unnormed.yml')
        unnormed = YAML.load_file(file).values

        Destination.all.each do |dest|

            unnormed_destination = unnormed.select{|d| d["destination_code"] == dest.destination_code}
            print(unnormed_destination)

            country = Country.find_by(country_code_3: unnormed_destination[0]["country_code_3"])
            print(country.inspect)

            country_id = country.id
            dest.country_id = country_id
            dest.save!

        end 

    end

end
