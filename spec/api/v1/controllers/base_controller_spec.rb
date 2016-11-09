require 'rails_helper'

RSpec.describe Api::V1::BaseController, type: :controller do
  let(:user) { User.create(email: Faker::Internet.email,
                           password: Faker::Internet.password,
                           api_auth_token: Faker::Internet.password(64, 64)) }

  context "authorized" do
    before :each do
      controller.request.env['HTTP_AUTHORIZATION'] = ActionController::HttpAuthentication::Token.encode_credentials(user.api_auth_token)
      controller.authenticate_user!
    end

    describe "#authenticate_user!" do
      it 'finds user by their token' do
        expect(assigns(:current_user)).to eq user
      end
    end
  end

end
