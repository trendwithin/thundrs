class Memory < ActiveRecord::Base
  belongs_to :creator, class_name: "User"
  has_many :comments
  has_and_belongs_to_many :keyword_associations, class_name: "Keyword"

  has_attached_file :image, default_url: "/img-300-placeholder.gif"
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/

  validates :name, presence: true
  validates :keywords, presence: true
  validates :description, presence: true

  def update_keyword_associations(new_keywords_string, old_keywords_string="")
    new_keywords = new_keywords_string.split(",").map { |e| e.strip }
    old_keywords = old_keywords_string.split(",").map { |e| e.strip }
    added_keywords = new_keywords - old_keywords
    removed_keywords = old_keywords - new_keywords

    removed_keywords.each do |keyword|
      assoc = Keyword.find_by(word: keyword)
      keyword_associations.delete(assoc) if assoc
    end

    added_keywords.each do |keyword|
      assoc = Keyword.find_or_create_by(word: keyword)
      keyword_associations << assoc if !keyword_associations.include? assoc
    end
  end
end
