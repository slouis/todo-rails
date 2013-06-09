class ChangeUserModel < ActiveRecord::Migration
  def change
  	rename_column :users, :password, :password_hash
  	add_column :users, :password_salt, :string
  end
end
