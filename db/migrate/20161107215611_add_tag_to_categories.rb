class AddTagToCategories < ActiveRecord::Migration
  def change
    add_reference :categories, :tag, foreign_key: true
  end
end
