require 'rails_helper'

RSpec.describe Api::V1::CategoriesController, type: :controller do
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
        category1
        get :index

        expect(response.body).to eq [category1].to_json
      end
    end

    describe "GET show" do
      it "succeeds" do
        get :show, id: category1

        expect(response).to have_http_status(:ok)
      end

      it "response with JSON" do
        get :show, id: category1

        expect(response.content_type).to eq 'application/json'
      end

      it "returns an error when record not found" do
        get :show, id: 34212

        expect(response).to have_http_status(404)
      end
    end

    describe "POST create" do

      it "successfully creates a category" do
        expect{ post :create, {"category": {"name": "Test Cat"}}, format: JSON}.to change{ Category.count }.by(1)
      end

      it "succeeds" do
        post :create, {"category": {"name": "Test Cat"}}, format: JSON

        expect(response).to have_http_status(:ok)
      end

      it "response with JSON" do
        post :create

        expect(response.content_type).to eq 'application/json'
      end

      it "returns an error when paramaters missing" do
        Category.create(name: "Test Cat")
        post :create, {"category": {"name": "Test Cat"}}, format: JSON

        expect(response.body).to include ("Category NOT added")
      end
    end

    describe "PUT update" do

      it "successfully updates a category" do
        category1
        put :update, {"category": {"name": "Updated Cat"}, "id": "#{category1.id}"}, format: JSON
        category1.reload

        expect(category1.name).to eq("Updated Cat")
      end

      it "returns an error when paramaters missing" do
        category1
        Category.create(name: "Cat")
        put :update, {"category": {"name": "Cat"}, "id": "#{category1.id}"}, format: JSON
        category1.reload

        expect(response.body).to include ("Category NOT updated")
      end
    end

    describe "DELETE destroy" do

      it "successfully deletes a category" do
        delete :destroy, id: category1.id, format: JSON
        expect(Category.count).to eq 0
      end

    end

  end
end
