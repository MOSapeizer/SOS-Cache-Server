require "uri"
require "net/http"
require "json"

# To send get or post request with custom payload.
# 
# Usage:
# => hello = XmlRequest.new( uri )
# => hello.get({service: "SOS", request: "GetCapabilities"})
#

module Core
	
	class XmlRequest

		attr_accessor :uri, :packet, :post

		def initialize(url)
			@uri = url
			@packet = Net::HTTP.new(uri.host, uri.port)
			@query = nil
		end

		def post(body=nil, &block)
			@post = Net::HTTP::Post.new(uri.path)
			@post["Content-type"] = "application/xml"
			@post.body = body
			# File.new("./response/send_post", "w").write body
			@res = send @post
			@result = yield @res.body if block_given?
		end

		def get(query={}, &block)
			fullPath = path_combine query
			p fullPath
			@get = Net::HTTP::Get.new(fullPath)
			@res = send @get
			# File.new("./response/tmp_GetCapability", "w").write @res.body
			@result = yield @res.body if block_given?
		end

		private

		def uri
			URI(@uri)
		end

		def path_combine(query={})
			params = URI.encode_www_form(query)
			[uri.path, params].join('?')
		end

		def send(action)
			@packet.request( action )
		end

	end
end



# xml = '<?xml version="1.0" encoding="UTF-8"?>
# <GetObservation service="SOS" version="2.0.0" xmlns="http://www.opengis.net/sos/2.0"  xmlns:wsa="http://www.w3.org/2005/08/addressing" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:swe="http://www.opengis.net/swe/2.0" xmlns:swes="http://www.opengis.net/swes/2.0" xmlns:fes="http://www.opengis.net/fes/2.0" xmlns:gml="http://www.opengis.net/gml/32" xmlns:ogc="http://www.opengis.net/ogc" xmlns:om="http://www.opengis.net/om/1.0" xsi:schemaLocation="http://www.w3.org/2003/05/soap-envelope http://www.w3.org/2003/05/soap-envelope/soap-envelope.xsd http://www.opengis.net/sos/2.0 http://schemas.opengis.net/sos/2.0/sos.xsd">
# 	<procedure>urn:ogc:object:feature:Sensor:SWCB:sensor鳳義坑</procedure>
# 	<offering>鳳義坑</offering>
# 	<observedProperty>urn:ogc:def:phenomenon:OGC:1.0.30:rainfall_1day</observedProperty>

# 	<responseFormat>application/json</responseFormat>
# </GetObservation>'


