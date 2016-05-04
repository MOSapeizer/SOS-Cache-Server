require_relative 'SOS/lib/sos-core.rb'


def sos
  Core::SOS.new('http://localhost:8080/twed_waterLevel/service')
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
      cache_property = CacheObservedProperty.new( property: value )
      cache_property.save
      OfferingProrpertyShip.create( cache_offering: cache_offering, cache_observed_property: cache_property )
    end

  end
end

task start: :environment do
  Rails.logger       = Logger.new(Rails.root.join('log', 'daemon.log'))
  Rails.logger.level = Logger.const_get((ENV['LOG_LEVEL'] || 'info').upcase)

  if ENV['BACKGROUND']
    Process.daemon(true, true)
  end

  if ENV['PIDFILE']
    File.open(ENV['PIDFILE'], 'w') { |f| f << Process.pid }
  end

  Signal.trap('TERM') { abort }

  Rails.logger.info "Start daemon..."

  loop do
    update_offering find_all_offerings
    puts "done"
    sleep 10 * 60
  end

end