class CreateLikes < ActiveRecord::Migration[6.0]
  def change
    create_table :likes do |t|
      t.references :user, null: false, foreign_key: { to_table: :users }
      t.references :post, null: false, foreign_key: { to_table: :users }
      t.timestamps
    end
  
  add_index :likes, [:user_id, :post_id], unique: true
  end
end
