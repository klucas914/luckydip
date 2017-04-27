# require 'httparty'

# Usage: rake import_scc_open_data
desc "Import SCCOpenData from www.gisservices.scc.qld.gov.au"
task import_scc_open_data: :environment do |t, args|
  location_types = [
    {
      name: 'Aquatic Centre',
      id:   1,
      fields: [
        'OBJECTID',
        'Name',
      ],
      parser: lambda do |feature|
        {
          id:          feature['attributes']['OBJECTID'],
          name:        feature['attributes']['Name'],
          address:     nil,
          description: nil,
          location:    [ feature['geometry']['x'], feature['geometry']['y'] ],
        }
      end,
    },
    {
      name: 'Aquatic Centre',
      id:   2,
      fields: [
        'OBJECTID',
        'Name',
      ],
      parser: lambda do |feature|
        {
          id:          feature['attributes']['OBJECTID'],
          name:        feature['attributes']['Name'],
          address:     nil,
          description: nil,
          location:    [ feature['geometry']['x'], feature['geometry']['y'] ],
        }
      end,
    },
    {
      name: 'Aquatic Centre',
      id:   3,
      fields: [
        'OBJECTID',
        'Name',
      ],
      parser: lambda do |feature|
        {
          id:          feature['attributes']['OBJECTID'],
          name:        feature['attributes']['Name'],
          address:     nil,
          description: nil,
          location:    [ feature['geometry']['x'], feature['geometry']['y'] ],
        }
      end,
    },
    {
      name: 'Library',
      id:   39,
      fields: [
        'OBJECTID',
        'Name',
        'Location_Description',
        'Website'
      ],
      parser: lambda do |feature|
        {
          id:          feature['attributes']['OBJECTID'],
          name:        feature['attributes']['Name'],
          address:     feature['attributes']['Location_Description'],
          description: feature['attributes']['Website'],
          location:    [ feature['geometry']['x'], feature['geometry']['y'] ],
        }
      end,
    },
    {
      name: 'Library',
      id:   41,
      fields: [
        'OBJECTID',
        'Name'
      ],
      parser: lambda do |feature|
        {
          id:          feature['attributes']['OBJECTID'],
          name:        feature['attributes']['Name'],
          address:     nil,
          description: nil,
          location:    [ feature['geometry']['x'], feature['geometry']['y'] ],
        }
      end,
    },
    
    #these are weekly markets only
    {
      name: 'Community Market',
      id:   16,
      fields: [
        'OBJECTID',
        'Name',
        'MarketAddress',
        'Hours'
      ],
      parser: lambda do |feature|
        {
          id:          feature['attributes']['OBJECTID'],
          name:        feature['attributes']['Name'],
          address:     feature['attributes']['MarketAddress'],
          description: feature['attributes']['Hours'],
          location:    [ feature['geometry']['x'], feature['geometry']['y'] ],
        }
      end,
    },
    # Only 2 of the community markets are downloading
    # { name: 'Fitness',          id: 22 },
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
        next if parsed_attributes[:name] == "result.name"
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

