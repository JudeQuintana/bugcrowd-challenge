class StatsController < ApplicationController

  def index
    render json: Stats.generate_for_all
  end

  def show

    @entity = Entity.find_by(entity_type: params["entity_type"], entity_id: params["entity_id"])

    if @entity.nil?
      render json: [], status: 404
    else
      render json: Stats.generate_for_single(@entity)
    end
  end
end