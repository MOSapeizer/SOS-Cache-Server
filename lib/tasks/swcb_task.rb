require_relative 'SOS/lib/sos-core.rb'
require_relative 'offering_task'

class SwcbTask < OfferingTask

  @@url = 'http://mos.csrsr.ncu.edu.tw:8080/swcb_cctv/service'

  def database
    CacheSwcb
  end

end