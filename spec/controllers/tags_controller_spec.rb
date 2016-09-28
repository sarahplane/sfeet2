require "rails_helper"

RSpec.describe TagsController, :type => :controller do

  before(:each) do
    @user = User.create(email: "12345@gmail.com", password: "123456", password_confirmation: "123456")
    @user.confirm
    @user.save
    sign_in @user
  end

  describe "DELETE #destroy" do
    it "successfully deletes a tag" do
      @tag = Tag.create(name: "Snackaroo")
      delete :destroy, :id => @tag.id

      expect(Tag.count).to eq(0)
    end
  end
end
