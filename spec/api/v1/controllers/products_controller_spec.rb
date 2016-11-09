require 'rails_helper'

RSpec.describe Api::V1::ProductsController, type: :controller do
  let(:user) { User.create(email: Faker::Internet.email,
                           password: Faker::Internet.password,
                           api_auth_token: Faker::Internet.password(64, 64)) }
  let(:product1) {Product.create(name: "Product1", price: "3")}

  context "unauthenticated user" do
    it "can't get index" do
      get :index

      expect(response).to have_http_status(401)
    end
  end

  context "authorized user" do
    before :each do
      controller.request.env['HTTP_AUTHORIZATION'] = ActionController::HttpAuthentication::Token.encode_credentials(user.api_auth_token)
    end

    describe "GET index" do
      it "succeeds" do
        get :index

        expect(response).to have_http_status(:ok)
      end

      it "responds with JSON" do
        get :index

        expect(response.content_type).to eq 'application/json'
      end

      it "succeeds" do
        product1
        get :index

        expect(response.body).to eq [product1].to_json
      end
    end

    describe "GET show" do
      it "succeeds" do
        get :show, id: product1

        expect(response).to have_http_status(:ok)
      end

      it "response with JSON" do
        get :show, id: product1

        expect(response.content_type).to eq 'application/json'
      end

      it "returns an error when record not found" do
        get :show, id: 34212

        expect(response).to have_http_status(404)
      end
    end
  end

end
