class Entity < ActiveRecord::Base
  validates_presence_of :entity_type, :entity_id, :tags
end