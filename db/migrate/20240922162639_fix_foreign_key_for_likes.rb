class FixForeignKeyForLikes < ActiveRecord::Migration[6.0]
  def change
    remove_foreign_key :likes, column: :post_id  # 誤った外部キーを削除
    add_foreign_key :likes, :posts, column: :post_id  # 正しい外部キーを追加
  end
end
