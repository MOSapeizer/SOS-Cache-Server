class TwedController < ApplicationController

	def index
    result = find_all_offerings
		render json: result, except: [:created_at, :updated_at]
	end

  def offering
		query = params[:offering]
		@offering = CacheTwed.find_by(offering: query)
    render json: error and return if @offering.nil?
		render json: @offering
	end

	protected

  def find_all_offerings
    CacheTwed.all
  end

end
