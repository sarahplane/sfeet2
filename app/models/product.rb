class Product < ActiveRecord::Base
  has_many :taggings
  has_many :tags, through: :taggings

  validates :name, presence: true, length: { minimum: 2 }, uniqueness: true

  def tag_list
    tags.collect{|tag| tag.name}.join(', ')
  end

  def tag_list=(tag_list)
    tag_names = tag_list.split(',').map{|name| name.strip.downcase}.uniq

    new_or_found_tags = tag_names.map do |name|
      Tag.find_or_create_by(name: name)
    end

    self.tags = new_or_found_tags
  end

end
