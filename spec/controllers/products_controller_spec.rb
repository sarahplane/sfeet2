require "rails_helper"

RSpec.describe ProductsController, :type => :controller do

  let(:product1) {Product.create(name: "Product1", price: "3")}
  let(:category1){Category.create(name: "Cat1")}


  context "non-user" do

    describe "GET #index" do
      it "succeeds" do
        get :index

        expect(response).to be_success
      end
    end

    describe "GET #show" do
      it "succeeds" do
        get :show, id: product1

        expect(response).to be_success
      end
    end

    describe "GET #new" do
      it "redirects to sign in if you are signed out" do
        get :new

        expect(response).to redirect_to new_user_session_path
      end
    end

  end


  context "Admin user" do

    before (:each) do
      @admin = User.create(email: "admin@user.com", password: "123456", admin: true, password_confirmation: "123456", confirmed_at: Time.now)
    end

    describe "PUT #update" do
      it "successfully updates changed to product" do
        sign_in @admin
        put :update, :id => product1.id, product: {price: "5"}
        product1.reload

        expect(product1.price).to eq "5"
      end
    end

    describe "DELETE #destroy" do
      it "successfully deletes an product" do
        sign_in @admin
        delete :destroy, :id => product1.id, method: :delete

        expect(Product.count).to eq 0
      end
    end

  end


  context "Non-Admin User" do

    before (:each) do
      @user = User.create(email: "user2@user.com", password: "123456", admin: false, password_confirmation: "123456", confirmed_at: Time.now)
    end

    describe "POST #create" do
      subject(:creation) {post :create, product: {name: 'Test 123', price: '1', category_id: category1.id}}

      it "successfully creates a product" do
        sign_in @user

        expect{creation}.to change{Product.count}.by(1)
      end

      it "raises an error if missing params" do
        sign_in @user
        product1 = Product.create(name: nil)

        expect(product1.errors[:name]).to include("can't be blank")
      end
    end

  end

end
