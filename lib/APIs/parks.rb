require 'soda/client'

client = SODA::Client.new({:domain => "data.sunshinecoast.qld.gov.au", :app_token => "sEY5VrKymwxyflwlu2SAlK0nr"})

results = client.get("adry-tzke", :$limit => 5000)

@park_name = results.parse["name"]

#puts "Got #{results.count} results. Dumping first results:"
#results.first.each do |k, v|
 # puts "#{key}: #{value}"
end