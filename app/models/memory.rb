class Memory < ActiveRecord::Base
  belongs_to :creator, class_name: "User"
  has_many :comments
  has_and_belongs_to_many :keyword_associations, class_name: "Keyword"
  has_many :related_memories,
    ->(m) { where.not(id: m.id) },
    through: :keyword_associations,
    source: :memories

  has_attached_file :image, default_url: "/img-300-placeholder.gif"
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/

  validates :name, presence: true
  validates :keywords, presence: true
  validates :description, presence: true

  def related_memories_sorted
    related_memories.group("memories.id").count.sort_by { |k,v| v }.reverse.map { |k,v| Memory.find(k) }
  end

  def update_keyword_associations(new_keywords_string, old_keywords_string = "")
    new_keywords = new_keywords_string.split(",").map(&:strip)
    old_keywords = old_keywords_string.split(",").map(&:strip)

    add_keyword_associations(new_keywords - old_keywords)
    remove_keyword_associations(old_keywords - new_keywords)
  end

  def remove_keyword_associations(removed_keyword_strings)
    removed_keyword_strings.each do |keyword|
      assoc = Keyword.find_by(word: keyword)
      keyword_associations.delete(assoc) if assoc
    end
  end

  def add_keyword_associations(added_keyword_strings)
    added_keyword_strings.each do |keyword|
      assoc = Keyword.find_or_create_by(word: keyword)
      keyword_associations << assoc unless keyword_associations.include? assoc
    end
  end
end
