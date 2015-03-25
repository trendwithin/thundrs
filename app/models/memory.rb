class Memory < ActiveRecord::Base
  belongs_to :creator, class_name: "User"
  has_many :comments

  has_attached_file :image, default_url: "/img-300-placeholder.gif"

  validates :name, presence: true
  validates :keywords, presence: true
  validates :description, presence: true
end
