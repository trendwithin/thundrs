class CreateJoinTableKeywordMemory < ActiveRecord::Migration
  def change
    create_join_table :keywords, :memories do |t|
      t.index [:keyword_id, :memory_id]
      # t.index [:memory_id, :keyword_id]
    end
  end
end
