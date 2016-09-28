require "rails_helper"

RSpec.describe ProductsController, :type => :controller do

  include Devise::Test::ControllerHelpers

  before(:each) do
    @user = User.create(email: "12345@gmail.com", password: "123456", password_confirmation: "123456")
    @user.confirm
    @user.save
    sign_in @user

    @product = Product.create(name: "Some Product", price: "3")
    @tags = ['yummy item', 'really yummy item', 'healthy item']
  end

  describe "GET #index" do
    it "succeeds" do
      get :index

      expect(response).to be_success
    end
  end


  describe "GET #new" do
    it "redirects to sign in if you are signed out" do
      sign_out @user
      get :new

      expect(response).to redirect_to new_user_session_path
    end
  end

  describe "POST #create" do
    subject(:creation) {post :create, product: {name: 'Test 123', price: '1'}}

    it "successfully creates a product" do
      expect{creation}.to change{Product.count}.by(1)
    end

    it "raises an error if missing params" do
      product1 = { product: {name: nil}}

      expect do
        post :create, product
        (product1.valid?).to_not eq true
      end
    end
  end

  describe "PUT #update" do

    it "successfully updates changed to product" do
      put :update, :id => @product.id, product: {price: "5"}
      @product.reload

      expect(@product.price).to eq "5"
    end
  end

  describe "DELETE #destroy" do
    it "successfully deletes an product" do
      delete :destroy, :id => @product.id, method: :delete

      expect(Product.count).to eq 0
    end
  end

end
