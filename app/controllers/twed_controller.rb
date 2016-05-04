class TwedController < ApplicationController

	def index
    result = find_all_offerings
		render json: result
	end

  def offering
		query = params[:offering]
		@offering = CacheTwed.find_by(offering: query)
    render json: error and return if @offering.nil?
		render json: @offering
	end

	protected

	def offering_to_json(offering)
		{  offering: offering.identifier.to_s,
		   procedure: offering.procedure.to_s,
		   observedProperty: offering.observableProperty.map { |property| property.to_s },
		   beginTime: offering.phenomenonTime.beginPosition.to_s,
		   endTime: offering.phenomenonTime.endPosition.to_s }
  end

  def find_all_offerings
    CacheTwed.all
  end

end
