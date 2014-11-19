class EntitiesController < ApplicationController
  def create

    json = JSON.parse(request.body.read)

    @entity = Entity.find_or_initialize_by(entity_id: json["entity_id"])

    if @entity.update(entity_type: json["entity_type"], tags: json["tags"])
      render nothing: true
    else
      render :json => [], status: :unprocessable_entity
    end
  end

  def show

    @entity = Entity.where(entity_type: params["entity_type"], entity_id: params["entity_id"])

    if @entity.empty?
      render :json => [], status: 404
    else
      render :json => @entity, except:[:id] #dont need show id since entity_id is unique should
                                            #probably figure out how to make entity_id the PK
    end
  end

  def destroy

    @entity = Entity.find_by(entity_type: params["entity_type"], entity_id: params["entity_id"])

    unless @entity.nil?
      @entity.destroy
    end

    render :nothing => true
  end

end