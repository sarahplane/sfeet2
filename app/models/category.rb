class Category < ActiveRecord::Base
  has_many :products
  has_many :tags

  validates :name, presence: true, length: { minimum: 2 }, uniqueness: true

  scope :sorted, -> {order(:name)}
end
