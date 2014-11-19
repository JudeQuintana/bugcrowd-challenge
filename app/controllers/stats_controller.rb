class StatsController < ApplicationController

  def index

    tags_arr = Entity.all.map(&:tags).flatten.uniq

    render :json => Stats.new(tags_arr).generate
  end

  def show

    @entity = Entity.find_by(entity_type: params["entity_type"], entity_id: params["entity_id"])

    if @entity.nil?
      render :json => [], status: 404
    else
      tags_arr = @entity.tags.flatten.uniq

      render :json => Stats.new(tags_arr).generate
    end
  end
end