class CreateTagging < ActiveRecord::Migration
  def change
    create_table :taggings do |t|
      t.references :product, index: true
      t.references :tag, index: true

      t.timestamps
    end
  end
end
