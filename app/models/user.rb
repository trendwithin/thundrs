class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :rememberable, :trackable, :validatable

  has_many :memories, foreign_key: "creator_id"
  has_many :comments, foreign_key: "author_id"
  has_many :replies, class_name: "Comment", through: :memories, source: :comments

  validates :username, presence: true, length: { maximum: 50 }
  validates :email, presence: true, length: { maximum: 255 }

  enum role: [:user, :admin]
end
