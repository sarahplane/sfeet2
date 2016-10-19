require "rails_helper"

RSpec.describe ProductsHelper, :type => :helper do

  let(:user){User.create(email: "user2@user.com", password: "123456", admin: false, password_confirmation: "123456", confirmed_at: Time.now)}
  let(:product1){Product.create(name: "Product1", price: "3")}
  let(:review1){Review.create(rating: "4", comment: "review1", product_id: product1.id, user_id: user.id)}
  let(:review2){Review.create(rating: "2", comment: "review2", product_id: product1.id, user_id: user.id)}

  describe "price_range" do
    it "converts the price to display $ times price" do
      price = product1.price

      expect(price_range(product1.price)).to eq "$$$"
    end
  end

  describe "review_sample" do
    it "takes a random review and displays it" do
      product1
      review1
      review2

      expect(review_sample(product1)).to include("#{review1.comment}") | include("#{review2.comment}")
    end
  end

end
