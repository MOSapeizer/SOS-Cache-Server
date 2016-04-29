require_relative 'sos-core.rb'

# service = SOS.new("http://cgis.csrsr.ncu.edu.tw:8080/swcb-sos-new/service")
# service.getCapabilities 

# offering = service.offerings[2]

# pt = offering.phenomenonTime
# p pt.beginPosition.toTimeZone
# p "get Offering"

# t = TestSOS.new("http://cgis.csrsr.ncu.edu.tw:8080/swcb-sos-new/service")
# t.getDay 2
# 
t = SOS.new("http://cgis.csrsr.ncu.edu.tw:8080/swcb-sos-new/service")
caps = t.getCapabilities
offerings = caps.contents.offerings
a = offerings.map{ |offering| { offering: offering.identifier, procedure: offering.procedure,  observedProperty: offering.observableProperty, phenomenonTime: { begin: offering.phenomenonTime.beginPosition, end: offering.phenomenonTime.endPosition }} }
# p offerings[2].phenomenonTime.endPosition

# this is the basic usage of a request from client
req = t.getObservations
req.offering = a[1][:offering]
req.observedProperty = a[1][:observedProperty]
time = a[1][:phenomenonTime][:begin].toTimeZone + " " + a[1][:phenomenonTime][:end].toTimeZone
req.temporalFilter = time
res = ""
ls = req.send do |response| 
	res = SOSHelper::Observation.new(response) 
	res.parse
	next res.to_json
end

p ls