require 'rails_helper'

RSpec.describe Api::V1::TagsController, type: :controller do
  let(:user) { User.create(email: Faker::Internet.email,
                           password: Faker::Internet.password,
                           api_auth_token: Faker::Internet.password(64, 64)) }
  let(:product1) { Product.create(name: "Product1", price: "3") }
  let(:category1) { Category.create(name: "Cat1") }
  let(:tags) { Tag.create(name: "Test1, Test2, Test3")}
  let(:tag1) { Tag.create(name: "Tag1")}

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
        tag1
        get :index

        expect(response.body).to eq [tag1].to_json
      end
    end

    describe "GET show" do
      it "succeeds" do
        get :show, id: tag1

        expect(response).to have_http_status(:ok)
      end

      it "response with JSON" do
        get :show, id: tag1

        expect(response.content_type).to eq 'application/json'
      end

      it "returns an error when record not found" do
        get :show, id: 34212

        expect(response).to have_http_status(404)
      end
    end

    describe "POST create" do

      it "successfully creates a tag" do
        expect{ post :create, {"tag": {"name": "tagtag"}}, format: JSON}.to change{ Tag.count }.by(1)
      end

      it "succeeds" do
        post :create, {"tag": {"name": "tagtag"}}, format: JSON

        expect(response).to have_http_status(:ok)
      end

      it "response with JSON" do
        post :create

        expect(response.content_type).to eq 'application/json'
      end

      it "returns an error when paramaters missing" do
        Tag.create(name: "tagtag")
        post :create, {"tag": {"name": "tagtag"}}, format: JSON

        expect(response.body).to include ("Tag NOT added")
      end
    end

    describe "PUT update" do

      it "successfully updates a tag" do
        tag1
        put :update, {"tag": {"name": "tagUpdate"}, "id": "#{tag1.id}"}, format: JSON
        tag1.reload

        expect(tag1.name).to eq("tagUpdate")
      end

      it "returns an error when paramaters missing" do
        tag1
        Tag.create(name: "tagtest")
        put :update, {"tag": {"name": "tagtest"}, "id": "#{tag1.id}"}, format: JSON
        tag1.reload

        expect(response.body).to include ("Tag NOT updated")
      end
    end

    describe "DELETE destroy" do

      it "successfully deletes a tag" do
        delete :destroy, {"tag": {"name": "tagUpdate"}, "id": "#{tag1.id}"}, format: JSON

        expect(Tag.count).to eq 0
      end

    end
    
  end
end
