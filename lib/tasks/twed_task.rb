require_relative 'SOS/lib/sos-core.rb'
class TwedTask

  class SwcbTask

    def sos
      Core::SOS.new('http://mos.csrsr.ncu.edu.tw:8080/twed_waterLevel/service')
    end

    def get_offerings
      caps = sos.getCapabilities
      caps.contents.offerings
    end

    def find_all_offerings
      offerings = get_offerings
      offerings.map { |offering| offering_to_json offering }
    end

    def offering_to_json(offering)
      {  offering: offering.identifier.to_s,
         procedure: offering.procedure.to_s,
         observedProperty: offering.observableProperty.map { |property| property.to_s },
         beginTime: offering.phenomenonTime.beginPosition.to_s,
         endTime: offering.phenomenonTime.endPosition.to_s }
    end

    def update_offering(result=[])
      result.each do |offering|

        cache_offering = CacheTwed.new
        cache_offering.offering = offering[:offering]
        cache_offering.procedure = offering[:procedure]
        cache_offering.beginTime = offering[:beginTime]
        cache_offering.endTime = offering[:endTime]
        cache_offering.save

        offering[:observedProperty].to_a.each do |value|
          cache_property = ObservedProperty.new(property: value )
          cache_property.save
          OfferingProrpertyShip.create( cache_offering: cache_offering, cache_observed_property: cache_property )
        end
      end
    end
  end
end