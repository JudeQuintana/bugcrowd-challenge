class Stats

  def initialize(tags_arr)
    @tags_arr = tags_arr
  end

  def generate

    @tags_arr.each_with_object([]) { |tag, arr|
      count = Entity.where("? = ANY (tags)", tag).count

      arr << {:tag => tag, :count => count}
    }
  end
end