require 'rails_helper'

RSpec.describe Category, type: :model do

  before (:each) do
    @category = Category.create(name: "Cat1")
  end

  context "validation" do

    it "requires a unique name" do
      cat_test = Category.create(name: "Cat1")

      expect(cat_test.valid?).to_not eq true
    end

    it "prevents name from being too short" do
      cat2 = Category.create(name: "C")

      expect(cat2.valid?).to_not eq true
    end
  end
end
