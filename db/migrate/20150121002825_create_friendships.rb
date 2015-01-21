class CreateFriendships < ActiveRecord::Migration
  def change
    create_table :friendships do |t|
      t.references :usuario, index: true
      t.references :friend, index: true

      t.timestamps null: false
    end
    add_foreign_key :friendships, :usuarios
    add_foreign_key :friendships, :friends
  end
end
