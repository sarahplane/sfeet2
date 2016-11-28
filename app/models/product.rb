class Product < ActiveRecord::Base

  has_many :taggings
  has_many :tags, through: :taggings
  has_many :reviews, dependent: :destroy
  belongs_to :category

  validates :name, presence: true, length: { minimum: 2 }, uniqueness: true


  def self.search(search)
    if search.nil?
      all.order('created_at DESC')
    else
      products = Product.arel_table
      search_term = sanitize_sql_like(search)
      Product.where(products[:name].matches("%#{search_term}%")).order("created_at DESC")
    end
  end

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
