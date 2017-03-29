require 'httparty'

  #def get_location_features location latitude longitude distance
   # @location_features = json.parse(data)
  #end
class SCCOpenData
  include HTTParty

  base_uri = 'www.gisservices.scc.qld.gov.au'

  default_timeout 1

  attr_accessor :fields, :features

  def base_path
    "arcgis/rest/services/Society/Society_SCRC/MapServer"
  end

  def query_with_bounding_box_and_features
    "/query?where=1%3D1&text=&objectIds=&time=&geometry=%7Bxmin%3A+153.073286%2C+ymin%3A+-26.650181%2C+xmax%3A+153.087902%2C+ymax%3A+-26.641052%7D&geometryType=esriGeometryEnvelope&inSR=4326&spatialRel=esriSpatialRelIntersects&relationParam=&outFields=*&returnGeometry=true&maxAllowableOffset=&geometryPrecision=&outSR=4326&returnIdsOnly=false&returnCountOnly=false&orderByFields=&groupByFieldsForStatistics=&outStatistics=&returnZ=false&returnM=false&gdbVersion=&returnDistinctValues=false&f=pjson"
  end

  def build_url_from_options(options)
  	if options[:objectid]
		"#{base_path}/#{ options[:objectid] }#{query_with_bounding_box_and_features}"
    else
    	raise ArgumentError, "options must specify OBJECTID"
    end
  end

  def examples_for_objects(OBJECTID, options {})
  	url = "#{base_path}#{OBJECTID}"
  	self.class.get(url, options)['fields']['features']
  end
end

#Object_Id:
#'/42'

#Query:
#'/query?where=1%3D1&text=&objectIds=&time=&geometry=%7Bxmin%3A+153.073286%2C+ymin%3A+-26.650181%2C+xmax%3A+153.087902%2C+ymax%3A+-26.641052%7D&geometryType=esriGeometryEnvelope&inSR=4326&spatialRel=esriSpatialRelIntersects&relationParam=&outFields=*&returnGeometry=true&maxAllowableOffset=&geometryPrecision=&outSR=4326&returnIdsOnly=false&returnCountOnly=false&orderByFields=&groupByFieldsForStatistics=&outStatistics=&returnZ=false&returnM=false&gdbVersion=&returnDistinctValues=false&f=pjson'

#URL for parks on sunshine coast: park name, coordinates (42)
# https://gisservices.scc.qld.gov.au/arcgis/rest/services/Society/Society_SCRC/MapServer/42/query?where=&text=&objectIds=&time=&geometry=XMin%3A+%2B153.073286%0D%0AYMin%3A+-26.650181%0D%0AXMax%3A+%2B153.087902%0D%0AYMax%3A+-26.641052%0D%0A&geometryType=esriGeometryEnvelope&inSR=102100+%283857%29++&spatialRel=esriSpatialRelIntersects&relationParam=&outFields=&returnGeometry=true&maxAllowableOffset=&geometryPrecision=&outSR=4326&returnIdsOnly=false&returnCountOnly=false&orderByFields=&groupByFieldsForStatistics=&outStatistics=&returnZ=false&returnM=false&gdbVersion=&returnDistinctValues=false&f=pjson

#Aquatic Centres (1)
#https://gisservices.scc.qld.gov.au/arcgis/rest/services/Society/Society_SCRC/MapServer/1/query?where=&text=&objectIds=&time=&geometry=XMin%3A+%2B153.073286%0D%0AYMin%3A+-26.650181%0D%0AXMax%3A+%2B153.087902%0D%0AYMax%3A+-26.641052%0D%0A&geometryType=esriGeometryEnvelope&inSR=102100+%283857%29++&spatialRel=esriSpatialRelIntersects&relationParam=&outFields=&returnGeometry=true&maxAllowableOffset=&geometryPrecision=&outSR=4326&returnIdsOnly=false&returnCountOnly=false&orderByFields=&groupByFieldsForStatistics=&outStatistics=&returnZ=false&returnM=false&gdbVersion=&returnDistinctValues=false&f=pjson

#Patrolled Beaches (6)
#https://gisservices.scc.qld.gov.au/arcgis/rest/services/Society/Society_SCRC/MapServer/6/query?where=&text=&objectIds=&time=&geometry=XMin%3A+%2B153.073286%0D%0AYMin%3A+-26.650181%0D%0AXMax%3A+%2B153.087902%0D%0AYMax%3A+-26.641052%0D%0A&geometryType=esriGeometryEnvelope&inSR=102100+%283857%29++&spatialRel=esriSpatialRelIntersects&relationParam=&outFields=&returnGeometry=true&maxAllowableOffset=&geometryPrecision=&outSR=4326&returnIdsOnly=false&returnCountOnly=false&orderByFields=&groupByFieldsForStatistics=&outStatistics=&returnZ=false&returnM=false&gdbVersion=&returnDistinctValues=false&f=pjson

#Fitness Area (22)
#https://gisservices.scc.qld.gov.au/arcgis/rest/services/Society/Society_SCRC/MapServer/22/query?where=&text=&objectIds=&time=&geometry=XMin%3A+%2B153.073286%0D%0AYMin%3A+-26.650181%0D%0AXMax%3A+%2B153.087902%0D%0AYMax%3A+-26.641052%0D%0A&geometryType=esriGeometryEnvelope&inSR=102100+%283857%29++&spatialRel=esriSpatialRelIntersects&relationParam=&outFields=&returnGeometry=true&maxAllowableOffset=&geometryPrecision=&outSR=4326&returnIdsOnly=false&returnCountOnly=false&orderByFields=&groupByFieldsForStatistics=&outStatistics=&returnZ=false&returnM=false&gdbVersion=&returnDistinctValues=false&f=pjson

#Libraries (39)
#https://gisservices.scc.qld.gov.au/arcgis/rest/services/Society/Society_SCRC/MapServer/39/query?where=&text=&objectIds=&time=&geometry=XMin%3A+%2B153.073286%0D%0AYMin%3A+-26.650181%0D%0AXMax%3A+%2B153.087902%0D%0AYMax%3A+-26.641052%0D%0A&geometryType=esriGeometryEnvelope&inSR=102100+%283857%29++&spatialRel=esriSpatialRelIntersects&relationParam=&outFields=&returnGeometry=true&maxAllowableOffset=&geometryPrecision=&outSR=4326&returnIdsOnly=false&returnCountOnly=false&orderByFields=&groupByFieldsForStatistics=&outStatistics=&returnZ=false&returnM=false&gdbVersion=&returnDistinctValues=false&f=pjson

#Public Artwork (47)
#https://gisservices.scc.qld.gov.au/arcgis/rest/services/Society/Society_SCRC/MapServer/47/query?where=&text=&objectIds=&time=&geometry=XMin%3A+%2B153.073286%0D%0AYMin%3A+-26.650181%0D%0AXMax%3A+%2B153.087902%0D%0AYMax%3A+-26.641052%0D%0A&geometryType=esriGeometryEnvelope&inSR=102100+%283857%29++&spatialRel=esriSpatialRelIntersects&relationParam=&outFields=&returnGeometry=true&maxAllowableOffset=&geometryPrecision=&outSR=4326&returnIdsOnly=false&returnCountOnly=false&orderByFields=&groupByFieldsForStatistics=&outStatistics=&returnZ=false&returnM=false&gdbVersion=&returnDistinctValues=false&f=pjson

#Dog Park (59)
#https://gisservices.scc.qld.gov.au/arcgis/rest/services/Society/Society_SCRC/MapServer/59/query?where=&text=&objectIds=&time=&geometry=XMin%3A+%2B153.073286%0D%0AYMin%3A+-26.650181%0D%0AXMax%3A+%2B153.087902%0D%0AYMax%3A+-26.641052%0D%0A&geometryType=esriGeometryEnvelope&inSR=102100+%283857%29++&spatialRel=esriSpatialRelIntersects&relationParam=&outFields=&returnGeometry=true&maxAllowableOffset=&geometryPrecision=&outSR=4326&returnIdsOnly=false&returnCountOnly=false&orderByFields=&groupByFieldsForStatistics=&outStatistics=&returnZ=false&returnM=false&gdbVersion=&returnDistinctValues=false&f=pjson

#Community Gardens (15)
#https://gisservices.scc.qld.gov.au/arcgis/rest/services/Society/Society_SCRC/MapServer/15/query?where=&text=&objectIds=&time=&geometry=XMin%3A+%2B153.073286%0D%0AYMin%3A+-26.650181%0D%0AXMax%3A+%2B153.087902%0D%0AYMax%3A+-26.641052%0D%0A&geometryType=esriGeometryEnvelope&inSR=102100+%283857%29++&spatialRel=esriSpatialRelIntersects&relationParam=&outFields=&returnGeometry=true&maxAllowableOffset=&geometryPrecision=&outSR=4326&returnIdsOnly=false&returnCountOnly=false&orderByFields=&groupByFieldsForStatistics=&outStatistics=&returnZ=false&returnM=false&gdbVersion=&returnDistinctValues=false&f=pjson

