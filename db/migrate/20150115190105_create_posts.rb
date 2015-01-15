class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :titulo
      t.text :contenido
      t.string :extension
      t.references :usuario, index: true

      t.timestamps null: false
    end
    add_foreign_key :posts, :usuarios
  end
end
