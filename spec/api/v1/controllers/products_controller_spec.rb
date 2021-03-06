require 'rails_helper'

RSpec.describe Api::V1::ProductsController, type: :controller do
  let(:user) { User.create(email: Faker::Internet.email,
                           password: Faker::Internet.password,
                           api_auth_token: Faker::Internet.password(64, 64)) }
  let(:product1) { Product.create(name: "Product1", price: "3") }
  let(:category1) { Category.create(name: "Cat1") }

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

    describe "POST create" do

      it "successfully creates a product" do
        expect{ post :create, {"product": {"name": "testgwgwgw", "price": "2"}, "tag_list": "test, test1, test3", "category_id": "#{category1.id}"}, format: JSON}.to change{ Product.count }.by(1)
      end

      it "succeeds" do
        post :create, {"product": {"name": "test123123123", "price": "2"}, "tag_list": "test, test1, test3", "category_id": "#{category1.id}"}, format: JSON

        expect(response).to have_http_status(:ok)
      end

      it "response with JSON" do
        post :create

        expect(response.content_type).to eq 'application/json'
      end

      it "returns an error when paramaters missing" do
        Product.create(name: "testgwgwgw", price: "2")
        post :create, {"product": {"name": "testgwgwgw", "price": "2"}, "tag_list": "test, test1, test3", "category_id": "#{category1.id}"}, format: JSON

        expect(response.body).to include ("Product NOT added")
      end
    end

    describe "PUT update" do

      it "successfully updates a product" do
        product1
        put :update, {"product": {"name": "UpdatedProduct", "price": "2"}, "tag_list": "test, test1, test3", "category_id": "#{category1.id}", "id": "#{product1.id}"}, format: JSON
        product1.reload

        expect(product1.name).to eq("UpdatedProduct")
      end

      it "returns an error when paramaters missing" do
        product1
        Product.create(name: "UpdatedProduct", price: "2")
        put :update, {"product": {"name": "UpdatedProduct", "price": "2"}, "tag_list": "test, test1, test3", "category_id": "#{category1.id}", "id": "#{product1.id}"}, format: JSON
        product1.reload

        expect(response.body).to include ("Product NOT updated")
      end
    end

    describe "DELETE destroy" do

      it "successfully deletes a product" do
        delete :destroy, {"product": {"name": "UpdatedProduct", "price": "2"}, "tag_list": "test, test1, test3", "category_id": "#{category1.id}", "id": "#{product1.id}"}, format: JSON

        expect(Product.count).to eq 0
      end

    end

  end
end
