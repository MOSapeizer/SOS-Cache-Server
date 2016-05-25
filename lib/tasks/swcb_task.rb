require_relative 'SOS/lib/sos-core.rb'
require_relative 'offering_task'

class SwcbTask < OfferingTask

  def initialize
    @url = 'http://mos.csrsr.ncu.edu.tw:8080/swcb_cctv/service'
    super @url
  end

  def database
    CacheSwcb
  end

  def find_all_observations
    offerings = database.all.map(&:offering)
    @go = sos.getObservations
    @go.offering = offerings
    @go.send do |response|
      obs = SOSHelper::Observation.new response
      next obs.parse
    end
  end

end