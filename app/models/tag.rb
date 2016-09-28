class Tag < ActiveRecord::Base
   has_many :taggings
   has_many :products, through: :taggings

   validates :name, presence: true, length: { minimum: 2 }, uniqueness: true
 end
