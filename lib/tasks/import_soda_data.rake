require 'soda/client'

# Usage: rake import_soda_data
desc "Import park data from soda gem https://github.com/socrata/soda-ruby"
task import_soda_data: :environment do |t, args|
  puts "importing data from soda..."
  client  = SODA::Client.new({:domain => "data.sunshinecoast.qld.gov.au", :app_token => "sEY5VrKymwxyflwlu2SAlK0nr"})
  results = client.get("adry-tzke", :$limit => 5000)
  puts "#{results.length} locations received"

  location_type    = LocationType.find_or_create_by(name: "Parks")
  imported_results = 0

  results.each do |result|
    new_location = Location.find_or_create_by(
      name: result.name,
      address: "#{result.location}, #{result.suburb}",
      description: "#{result.comments}. Facilities available: #{result.facilities}"
    )
    new_location.location_type_ids = [ location_type.id ]

    if new_location.new_record?
      if new_location.save
        puts "#{result.name} was successfully imported"
        imported_results += 1
      else
        puts "======================================================"
        puts "PROBLEM IMPORTING #{result.name}!"
        puts "======================================================"
      end
    else
      puts "#{result.name} already exists"
    end
  end

  puts "#{imported_results} parks imported"
  puts "rake task finished"
end
