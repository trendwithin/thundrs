class Comment < ActiveRecord::Base
  belongs_to :author, class_name: "User", foreign_key: "author_id"
  belongs_to :memory

  def self.permitted_attributes
    [:body, :author_id, :memory_id]
  end

  def permitted_attributes
    [:approved]
  end
end
