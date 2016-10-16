require "rails_helper"

RSpec.describe ProductsHelper, :type => :helper do

  let(:product1) {Product.create(name: "Product1", price: "3")}

  describe "price_range" do
    it "converts the price to display $ times price" do
      price = product1.price

      expect(price_range(product1.price)).to eq "$$$"
    end
  end

end
