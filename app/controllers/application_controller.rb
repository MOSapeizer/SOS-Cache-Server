class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  include Core
  protect_from_forgery with: :exception

  def error
		{ error: "can't find the offering" }
  end

  def basic
		# req = sos.getObservations
		# req.offering = a[1][:offering]
		# req.observedProperty = a[1][:observedProperty]
		# 
		# time = a[1][:phenomenonTime][:begin].toTimeZone + " " 
		# 		 + a[1][:phenomenonTime][:end].toTimeZone
		# 		 
		# req.temporalFilter = time
		# res = ""
		# ls = req.send do |response| 
		# 	res = SOSHelper::Observation.new(response) 
		# 	res.parse
		# 	next res.to_json
		# end
		# 
  end
end
