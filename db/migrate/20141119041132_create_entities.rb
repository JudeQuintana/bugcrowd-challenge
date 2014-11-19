class CreateEntities < ActiveRecord::Migration
  def change
    create_table :entities do |t|
      t.string :entity_type
      t.string :entity_id
      t.string :tags, :array => true
    end
    add_index :entities, :entity_id, unique: true
    add_index :entities, :tags, using: 'gin'
  end
end
