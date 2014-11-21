class StatsController < ApplicationController

  def index

    #grabbing all tags from all Entities in collection
    tags_arr = Entity.all.map(&:tags).flatten.uniq

    render json: Stats.new(tags_arr).generate
  end

  def show

    @entity = Entity.find_by(entity_type: params["entity_type"], entity_id: params["entity_id"])

    if @entity.nil?
      render json: [], status: 404
    else
      #grabbing tags from single Entity
      tags_arr = @entity.tags.uniq

      render json: Stats.new(tags_arr).generate
    end
  end
end