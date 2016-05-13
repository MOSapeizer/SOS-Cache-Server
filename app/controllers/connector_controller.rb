class ConnectorController < ApplicationController
	include ConnectorHelper

	def index

  end

	def offering
		query = params[:offering]
		offering = findOffering query
		render json: error if offering.nil?
	end

  def findOffering(query)
    CacheOffering.find_by(offering: query);
  end
	
end
