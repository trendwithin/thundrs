class AddAttachmentImageToMemories < ActiveRecord::Migration
  def self.up
    change_table :memories do |t|
      t.attachment :image
    end
  end

  def self.down
    remove_attachment :memories, :image
  end
end
