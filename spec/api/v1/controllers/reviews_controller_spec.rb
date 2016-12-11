require 'rails_helper'

RSpec.describe Api::V1::ReviewsController, type: :controller do
  let(:user) { User.create(email: Faker::Internet.email,
                           password: Faker::Internet.password,
                           api_auth_token: Faker::Internet.password(64, 64)) }
  let(:product1) { Product.create(name: "Product1", price: "3") }
  let(:category1) { Category.create(name: "Cat1") }

  context "unauthenticated user" do
    it "can't get index" do
      post :create, {"review": {"rating": "3", "comment": "Test Comment"}, "product_id": "#{product1.id}"}, format: JSON

      expect(response).to have_http_status(401)
    end
  end

  context "authorized user" do
    before :each do
      controller.request.env['HTTP_AUTHORIZATION'] = ActionController::HttpAuthentication::Token.encode_credentials(user.api_auth_token)
    end

    describe "POST create" do

      it "successfully creates a review" do
        expect{ post :create, {"review": {"rating": "3", "comment": "Test Comment"}, "product_id": "#{product1.id}"}, format: JSON}.to change{ Review.count }.by(1)
      end

      it "succeeds" do
        post :create, {"review": {"rating": "3", "comment": "Test Comment"}, "product_id": "#{product1.id}"}, format: JSON

        expect(response).to have_http_status(:ok)
      end

      it "response with JSON" do
        post :create

        expect(response.content_type).to eq 'application/json'
      end

      it "returns an error when paramaters missing" do
        post :create, {"review": {"comment": "Test Comment"}, "product_id": "#{product1.id}"}, format: JSON

        expect(response.body).to include ("Review NOT added")
      end
    end

  end
end
