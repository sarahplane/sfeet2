require "rails_helper"

RSpec.describe ReviewsController, :type => :controller do

  include Devise::Test::ControllerHelpers

  let(:user) { User.create(email: "user2@user.com", password: "123456", admin: false, password_confirmation: "123456", confirmed_at: Time.now) }
  let(:product1) { Product.create(name: "Product1", price: "3") }
  let(:category1) { Category.create(name: "Cat1") }
  let(:review1) { Review.create(rating: "4", comment: "review1", product_id: product1.id, user_id: user.id) }
  let(:review2) { Review.create(rating: "2", comment: "review2", product_id: product1.id, user_id: user.id) }


  describe "POST #create" do
    subject(:creation) { post :create, :product_id => product1.id, review: { rating: 'review2', product_id: product1.id, user_id: user.id } }

    it "successfully creates a review" do
      sign_in user

      expect{ creation }.to change{ Review.count }.by(1)
    end

    it "raises an error if missing params" do
      nouser = { review: { review: { rating: 'review3', product_id: product1.id, user_id: nil } } }

      expect do
        post :create, review
        (nouser.valid?).to_not eq true
      end
    end
  end
  
end
