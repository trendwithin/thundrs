class CreateKeywords < ActiveRecord::Migration
  def change
    create_table :keywords do |t|
      t.string :word
      t.integer :count

      t.timestamps null: false
    end
  end
end
