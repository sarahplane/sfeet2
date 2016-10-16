require "rails_helper"

RSpec.describe CategoriesController, :type => :controller do

  include Devise::Test::ControllerHelpers

  before(:each) do
    @user = User.create(email: "12345@gmail.com", password: "123456", password_confirmation: "123456")
    @user.confirm
    @user.save
    sign_in @user
  end

  let(:category1){Category.create(name: "Cat1")}

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
    subject(:creation) {post :create, category: {name: 'Cat1'}}

    it "successfully creates a category" do
      expect{creation}.to change{Category.count}.by(1)
    end

    it "raises an error if missing params" do
      nocat = {category: {name: nil}}

      expect do
        post :create, category
        (nocat.valid?).to_not eq true
      end
    end
  end

  describe "PUT #update" do

    it "successfully updates changed to category" do
      put :update, :id => category1.id, category: {name: "CatChange"}
      category1.reload

      expect(category1.name).to eq "CatChange"
    end
  end

  describe "DELETE #destroy" do
    it "successfully deletes a Category" do
      delete :destroy, :id => category1.id, method: :delete

      expect(Category.count).to eq 0
    end
  end

end
