class CctvProxyController < ApplicationController
  include ConnectorHelper

  def cctv
    station = params[:station]
    ccd = params[:ccd]
    url = 'http://dfm.swcb.gov.tw/debrisFinal/QueryCCDRange.asp'
    query = { Stationid: station, CCDID: ccd, mode: 1 }
    packet = XmlRequest.new(url)
    json_response = packet.get( query ) do | response |
      next parse_to_json(response)
    end

    render json: json_response
  end

  private

  def parse_to_json(response)
    index = response.scan(/\d{8,10}/)
    timestamp = response.scan(/\d{4}\/\d{1,2}\/\d{1,2}\s\d{1,2}[:]\d{1,2}[:]\d{1,2}/)
    timestamp.slice!(-4, 4)

    return { index: index, timestamp: timestamp }

  end
end
