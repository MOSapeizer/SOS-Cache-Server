require "uri"
require "net/http"
require "json"

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

