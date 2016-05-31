require_relative 'SOS/lib/sos-core.rb'

class OfferingTask

  def initialize(url)
    @service = Core::SOS.new(url)
  end

  def database
  	CacheOffering
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

      cache_offering = database.new
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

  def clean_cache
    database.all.each do |data|
      data.observations.delete_all
    end
  end

  def save_observation
    update_observation find_all_observations
  end

  def find_all_observations

  end

  def update_observation(result=[])
    result.each do |observation|
      obs = Observation.find_by result: observation[:result]
      create_observation(observation) if obs.nil?

      # there we only parse reference of feature
      # so we need to send another request to get Position
      find_feature observation
    end
  end

  def create_observation( observation )
    p 'No observation, create one'
    cache_offering = database.find_by procedure: observation[:procedure]
    obs = cache_offering.observations.new
    obs.phenomenonTime = observation[:timeposition]
    obs.result = observation[:result]
    obs.save
    p 'observations created'
  end

  def find_feature( observation  )
    p 'Find out new feature info'
    observation[:featureOfInterest].to_a.each do |id|
      if Feature.find_by( name: id ).nil?
        p "Create A New feature: #{id}"
        offering = database.find_by procedure: observation[:procedure]
        create_feature(id, offering)
      end
    end
    p 'Feature updated done'
  end

  def create_feature(id, cache_offering)
    feature_info = find_feature_by id
    feature_info.each do |feature_unit|
      feature = Feature.new( name: id,
                             longitude: feature_unit[:longitude],
                             latitude: feature_unit[:latitude] )
      feature.save
      OfferingFeatureShip.create( cache_offering: cache_offering, feature: feature )
    end
  end

  def find_feature_by(name)
    @gf = sos.getFeatureOfInterest
    @gf.feature = name
    @gf.send do |response|
      feature = SOSHelper::FeatureOfInterest.new response
      next feature.parse
    end
  end



end