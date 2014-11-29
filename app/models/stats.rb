class Stats

  def self.generate_for_all

    #grabbing all tags from all Entities in collection
    tags_arr = Entity.all.map(&:tags).flatten.uniq

    #for each uniq tag count all entities that contain it
    tags_arr.each_with_object([]) { |tag, arr|
      count = Entity.where("? = ANY (tags)", tag).count

      arr << {:tag => tag, :count => count}
    }
  end

  def self.generate_for_single(entity)

    entity.tags.each_with_object([]) { |tag, arr|
      arr << {:tag => tag, :count => 1}
      #count is always one because tags are guaranteed unique
      #for every single entity
    }
  end

end