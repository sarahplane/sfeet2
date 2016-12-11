require "rails_helper"

RSpec.describe TagsController, :type => :controller do

  let(:product1) { Product.create(name: "Product1", price: "3") }
  let(:tag) { Tag.create(name: "Tag1") }

  context "Non-Admin User" do

    before (:each) do
      @user = User.create(email: "user2@user.com", password: "123456", admin: false, password_confirmation: "123456", confirmed_at: Time.now)
    end

    describe "GET #show" do
      it "succeeds" do
        get :show, id: tag

        expect(response).to be_success
      end
    end
  end


  context "Admin user" do
    before (:each) do
      @admin = User.create(email: "admin@user.com", password: "123456", admin: true, password_confirmation: "123456", confirmed_at: Time.now)
    end

    describe "PUT #update" do
      it "successfully updates changed to tag" do
        sign_in @admin
        put :update, :id => tag.id, tag: { name: "UpdatedTag" }
        tag.reload

        expect(tag.name).to eq "UpdatedTag"
      end
    end

    describe "DELETE #destroy" do
      it "successfully deletes a tag" do
        sign_in @admin
        @tag = Tag.create(name: "Snackaroo")
        delete :destroy, :id => @tag.id

        expect(Tag.count).to eq(0)
      end
    end
  end

end
