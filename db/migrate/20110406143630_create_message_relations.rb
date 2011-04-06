class CreateMessageRelations < ActiveRecord::Migration
  def self.up
    create_table :message_relations do |t|
      t.integer :user_id
      t.integer :message_id

      t.timestamps
    end
  end

  def self.down
    drop_table :message_relations
  end
end
