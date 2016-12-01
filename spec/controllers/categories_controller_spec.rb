require "rails_helper"

RSpec.describe CategoriesController, :type => :controller do

  include Devise::Test::ControllerHelpers

  let(:product1) { Product.create(name: "Product1", price: "3") }
  let(:category1) { Category.create(name: "Cat1") }

  context "Admin user" do
    before(:each) do
      @admin = User.create(email: "admin@user.com", password: "123456", admin: true, password_confirmation: "123456", confirmed_at: Time.now)
    end

    describe "GET #index" do
      it "succeeds" do
        sign_in @admin
        get :index

        expect(response).to be_success
      end
    end


    describe "POST #create" do
      subject(:creation){ post :create, category: { name: 'Cat2' } }

      it "successfully creates a category" do
        sign_in @admin

        expect{ creation }.to change{ Category.count }.by(1)
      end

      it "raises an error if missing params" do
        sign_in @admin
        nocat = Category.create(name: nil)

        expect(nocat.errors[:name]).to include("can't be blank")
      end
    end

    describe "PUT #update" do

      it "successfully updates change to category" do
        sign_in @admin
        put :update, :id => category1.id, category: { name: "CatChange" }
        category1.reload

        expect(category1.name).to eq "CatChange"
      end
    end

    describe "DELETE #destroy" do
      it "successfully deletes a Category" do
        sign_in @admin
        delete :destroy, :id => category1.id, format: 'js'

        expect(Category.count).to eq 0
      end
    end
  end

  context "Non-Admin user" do
    before(:each) do
      @user = User.create(email: "user2@user.com", password: "123456", admin: false, password_confirmation: "123456", confirmed_at: Time.now)
    end

    describe "GET #show" do
      it "succeeds" do
        get :show, id: category1

        expect(response).to be_success
      end
    end
  end
end
