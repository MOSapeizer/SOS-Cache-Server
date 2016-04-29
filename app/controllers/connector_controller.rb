class ConnectorController < ApplicationController
	include ConnectorHelper

	def index
		result = findAllOffering
		render json: result
	end

	def offering
		query = params[:offering]
		offering = findOffering query
		render json: error if offering.nil?

	end

  def findOffering(query)
    CacheOffering.find_by(offering: query);
  end

  protected

	def sos
		Core::SOS.new('http://cgis.csrsr.ncu.edu.tw:8080/swcb-sos-new/service')
  end

  def getOfferings
    caps = sos.getCapabilities
    caps.contents.offerings
  end

  def findAllOffering
    offerings = getOfferings
    offerings.map { |offering| offering_to_json offering }
  end

	def offering_to_json(offering)
		{  offering: offering.identifier,	
		   procedure: offering.procedure,
		   observedProperty: offering.observableProperty,
		   beginTime: offering.phenomenonTime.beginPosition,
		   endTime: offering.phenomenonTime.endPosition }
	end
	
end
