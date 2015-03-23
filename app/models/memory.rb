class Memory < ActiveRecord::Base
  belongs_to :creator, class_name: "User"
  has_many :comments
end
