require "rails_helper"

RSpec.describe ReviewsHelper, :type => :helper do

  let(:user) { User.create(email: "user2@user.com", password: "123456", admin: false, password_confirmation: "123456", confirmed_at: Time.now) }
  let(:product1) { Product.create(name: "Product1", price: "3") }
  let(:review1) { Review.create(rating: "4", comment: "review1", product_id: product1.id, user_id: user.id) }
  let(:review2) { Review.create(rating: "2", comment: "review2", product_id: product1.id, user_id: user.id) }

  describe "rating_average" do
    it "averages all review ratings for the product" do
      review1
      review2
      reviews = product1.reviews

      expect(rating_average(product1.reviews)).to eq 3
    end
  end

end
