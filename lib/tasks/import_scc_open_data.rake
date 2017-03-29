# require 'httparty'

# Usage: rake import_scc_open_data
desc "Import SCCOpenData from www.gisservices.scc.qld.gov.au"
task import_scc_open_data: :environment do |t, args|
  location_types = [
    {
      name: 'Playground',
      id:   42,
      fields: [
        'OBJECTID_1',
        'Park',
        'MXLOCATION',
      ],
      parser: lambda do |feature|
        {
          id:          feature['attributes']['OBJECTID_1'],
          name:        feature['attributes']['Park'],
          address:     feature['attributes']['MXLOCATION'],
          description: nil,
          location:    [ feature['geometry']['x'], feature['geometry']['y'] ],
        }
      end,
    },
    # { name: 'Aquatic Center',   id:  1 },
    # { name: 'Beach',            id:  6 },
    # { name: 'Fitness',          id: 22 },
    # { name: 'Library',          id: 39 },
    # { name: 'Public Art',       id: 47 },
    # { name: 'Dog Park',         id: 59 },
    {
      name: 'Community Garden',
      id:   15,
      fields: [
        'OBJECTID',
        'property_name',
        'address_format',
        'notes',
      ],
      parser: lambda do |feature|
        {
          id:          feature['attributes']['OBJECTID'],
          name:        feature['attributes']['property_name'],
          address:     feature['attributes']['address_format'],
          description: feature['attributes']['notes'],
          location:    Geocoder::Calculations.geographic_center(feature['geometry']['rings'][0]),
        }
      end,
    },
  ]

  base_url = "https://gisservices.scc.qld.gov.au/arcgis/rest/services/Society/Society_SCRC/MapServer"
  xmin = 153.073286
  ymin = -26.650181
  xmax = 153.087902
  ymax = -26.641052

  location_types.each do |location_type|
    l_type = LocationType.find_or_create_by(name: location_type[:name])
    puts "======================================================"
    puts "Importing locations of type #{location_type[:name]}..."
    puts "======================================================"
    request_url = "#{base_url}/#{location_type[:id]}/query?where=&text=&objectIds=&time=&geometry=XMin%3A+%2Bi#{xmin}%0D%0AYMin%3A+#{ymin}%0D%0AXMax%3A+%2B#{xmax}%0D%0AYMax%3A+#{ymax}%0D%0A&geometryType=esriGeometryEnvelope&inSR=102100+%283857%29++&spatialRel=esriSpatialRelIntersects&relationParam=&outFields=#{location_type[:fields].join(',')}&returnGeometry=true&maxAllowableOffset=&geometryPrecision=&outSR=4326&returnIdsOnly=false&returnCountOnly=false&orderByFields=&groupByFieldsForStatistics=&outStatistics=&returnZ=false&returnM=false&gdbVersion=&returnDistinctValues=false&f=pjson"
    response    = JSON.parse(HTTParty.get(request_url))

    if response['features'] and response['features'].length > 0
      puts "#{response['features'].length} locations received"
      count = 0

      response['features'].each do |feature|
        parsed_attributes = location_type[:parser].call(feature)
        existing_location = Location.where(scc_open_data_id: parsed_attributes[:id]).first
        unless existing_location
          puts "Importing location ID #{parsed_attributes[:id]}"
          new_location = Location.new(
            name:              parsed_attributes[:name],
            address:           parsed_attributes[:address],
            location_type_ids: [ l_type.id ],
            latitude:          parsed_attributes[:location][1],
            longitude:         parsed_attributes[:location][0],
            description:       parsed_attributes[:description],
            scc_open_data_id:  parsed_attributes[:id],
          )
          if new_location.save
            puts "Successfuly imported location ID #{parsed_attributes[:id]}"
            count = count + 1
          else
            puts "*** There was a problem importing location ID #{parsed_attributes[:id]}. ***"
          end
        end
      end

      puts "#{count} locations imported"
    end
  end

  puts "Finished."
end

