class SwcbController < ApplicationController

  def index
    @result = find_all_offerings
    render json: @result
  end

  def offering
    query = params[:offering]
    @offering = CacheSwcb.find_by(offering: query)
    render json: error and return if @offering.nil?
    render json: @offering.observations, except: [:id, :created_at, :updated_at, :cache_offering_id]
  end

  protected

  def find_all_offerings
    CacheSwcb.all
  end
end
