class CreateMemories < ActiveRecord::Migration
  def change
    create_table :memories do |t|
      t.string :name
      t.string :keywords
      t.text :description
      t.references :creator, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
