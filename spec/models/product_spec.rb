require 'rails_helper'

RSpec.describe Product, type: :model do

  before (:each) do
    @product = Product.create(name: "Some Product", price: "3")
    @tags = Tag.create{['yummy item', 'really yummy item', 'healthy item']}
  end

  context "validation" do

    let(:product){Product.create(name: "Some Product", price: "3")}
    let(:tags){['yummy item', 'snackaroo']}

    it "requires a unique name" do
      product

      expect(@product.valid?).to eq true
    end

    it "prevents name from being too short" do
    end
  end

  context "tags" do

    describe 'tag_list' do

      before (:each) do
        @product.tag_list = ("yummy item, really yummy item, healthy item")
        @product.save
      end

      it "will create tags out of a string" do
        expect(@product.tags[0].name).to eq "yummy item"
      end

      it "will be comma seperated" do
        expect(@product.tag_list).to eq "yummy item, really yummy item, healthy item"
      end
    end
  end

end
