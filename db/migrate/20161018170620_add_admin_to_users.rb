class AddAdminToUsers < ActiveRecord::Migration
  def change
    reversible do |dir|
      dir.up do
        add_column :users, :admin, :boolean, :default => false
      end
      dir.down do
        remove_column :users, :admin
      end
    end
  end
end
