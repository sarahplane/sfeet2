require "rails_helper"

RSpec.describe TagsController, :type => :controller do

  include Devise::Test::ControllerHelpers

  let(:user) {User.create(email: "admin@user.com", password: "123456", admin: true, password_confirmation: "123456", confirmed_at: Time.now)}
  let(:product1) {Product.create(name: "Product1", price: "3")}
  let(:tag) {Tag.create(name: "Tag1")}

  describe "DELETE #destroy" do
    it "successfully deletes a tag" do
      sign_in user
      @tag = Tag.create(name: "Snackaroo")
      delete :destroy, :id => @tag.id

      expect(Tag.count).to eq(0)
    end
  end

  describe "GET #show" do
    it "succeeds" do
      get :show, id: tag

      expect(response).to be_success
    end
  end
end
