class AddAttachmentImageToMemories < ActiveRecord::Migration
  def self.up
    add_attachment :memories, :image
  end

  def self.down
    remove_attachment :memories, :image
  end
end
