class Memory < ActiveRecord::Base
  belongs_to :creator, class_name: "User"
  has_many :comments


  validates :name, presence: true, length: { minimum: 1 }
  validates :keywords, presence: true, length: { minimum: 1 }
  validates :description, presence: true, length: { minimum: 1 }
end
