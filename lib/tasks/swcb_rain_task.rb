require_relative 'SOS/lib/sos-core.rb'
require_relative 'offering_task'

class SwcbRainTask < OfferingTask

  def initialize
    @url = 'http://140.115.111.186:8080/swcb-sos-new/service'
    super @url
  end

  def database
    CacheSwcbRain
  end

  def find_all_observations
    offerings = database.all.map(&:offering)
    @go = sos.getObservations
    @go.offering = offerings
    begin_time = Time.now
    range = begin_time.year.to_s + '-' + (begin_time.mon-3).to_s + '-' + (begin_time.day-2).to_s + 'T00:00:00.000Z ' +
             begin_time.year.to_s + '-' + (begin_time.mon-3).to_s + '-' + (begin_time.day).to_s + 'T00:00:00.000Z'
    @go.temporalFilter= range
    @go.send do |response|
      obs = SOSHelper::Observation.new response
      next obs.parse
    end
  end

end