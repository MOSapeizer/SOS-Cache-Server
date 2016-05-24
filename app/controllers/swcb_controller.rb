class SwcbController < ApplicationController

  def index
    result = find_all_offerings
    render json: result, except: [:created_at, :updated_at]
  end

  def offering
    query = params[:offering]
    @offering = CacheSwcb.find_by(offering: query)
    render json: error and return if @offering.nil?
    render json: @offering.observations, except: [:created_at, :updated_at, :cache_offering_id]
  end

  def observation

  end

  protected

  def find_all_offerings
    CacheSwcb.all
  end
end
