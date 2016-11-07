class Tag < ActiveRecord::Base
  belongs_to :category
  has_many :taggings
  has_many :products, through: :taggings

  validates :name, presence: true, length: { minimum: 2 }, uniqueness: true

  scope :sorted, -> {order(:name)}
 end
