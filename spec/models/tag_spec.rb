require 'rails_helper'

RSpec.describe Tag, type: :model do
  context "validation" do

    before (:each) do
      @tags = Tag.create(name: 'yummy item')
    end

    it "requires a unique name" do
      tag1 = Tag.create(name: 'yummy item')

      expect(tag1.valid?).to_not eq true
    end

    it "prevents name from being too short" do
      tag1 = Tag.create(name: "yummy item")

      expect(tag1.valid?).to_not eq true
    end
  end
end
