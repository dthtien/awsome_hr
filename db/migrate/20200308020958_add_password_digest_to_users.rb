class AddPasswordDigestToUsers < ActiveRecord::Migration[6.0]
  def change
    add_index :users, :username, unique: true
    add_column :users, :password_digest, :string
  end
end
