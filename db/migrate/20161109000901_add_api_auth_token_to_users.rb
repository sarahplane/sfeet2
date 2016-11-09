class AddApiAuthTokenToUsers < ActiveRecord::Migration
  def change
    add_column :users, :api_auth_token, :string
  end
end
