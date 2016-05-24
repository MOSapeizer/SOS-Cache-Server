require_relative 'SOS/lib/sos-core.rb'

class SwcbTask

  @@url = 'http://mos.csrsr.ncu.edu.tw:8080/swcb_cctv/service'

  def initialize
    @service = Core::SOS.new(@@url)
  end

  def sos
    @service
  end

  def save
    update_offering find_all_offerings
  end

  def get_offerings
    @caps = sos.getCapabilities
    @caps.contents.offerings
  end

  def find_all_offerings
    offerings = get_offerings
    offerings.map { |offering| offering_to_json offering }
  end

  def offering_names
    offerings = get_offerings
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

      cache_offering = CacheSwcb.new
      cache_offering.offering = offering[:offering]
      cache_offering.procedure = offering[:procedure]
      cache_offering.beginTime = offering[:beginTime]
      cache_offering.endTime = offering[:endTime]
      cache_offering.save

      offering[:observedProperty].to_a.each do |value|
        cache_property = CacheObservedProperty.new( property: value )
        cache_property.save
        OfferingProrpertyShip.create( cache_offering: cache_offering, cache_observed_property: cache_property )
      end
    end
  end

  def save_observation
    update_observation find_all_observations
  end

  def update_observation(result=[])
    result.each do |observation|
      obs = Observation.find_by result: observation[:result]
      if obs.nil?
        cache_offering = CacheSwcb.find_by procedure: observation[:procedure]
        obs = cache_offering.observations.new
        obs.phenomenonTime = observation[:timeposition]
        obs.result = observation[:result]
        obs.save
      end
    end
  end

  def find_all_observations
    offerings = CacheSwcb.all.map(&:offering)
    @go = sos.getObservations
    @go.offering = offerings

    observationsGroup = @go.send do |response|
      obs = SOSHelper::Observation.new response
      next obs.parse
    end
  end

end