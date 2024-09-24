# == Schema Information
#
# Table name: comments
#
#  id         :bigint           not null, primary key
#  content    :text             not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  post_id    :bigint           not null
#  user_id    :bigint           not null
#
# Indexes
#
#  index_comments_on_post_id  (post_id)
#  index_comments_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (post_id => posts.id)
#  fk_rails_...  (user_id => users.id)
#
require 'rails_helper'

RSpec.describe Comment, type: :model do
  context '正しい情報が与えられた場合' do
    let!(:comment) { build(:comment) }

    before do
      comment.save
      puts comment.post.inspect  # ここでpostが正しく作成されているか確認
    end

    it '投稿が保存される' do
      expect(comment).to be_valid
    end
  end

  context 'コメントが無かった場合' do
    let!(:comment) { build(:comment, content: '') }

    before do
      comment.save
    end

    it '投稿が保存されない' do
      expect(comment).not_to be_valid
      expect(comment.errors.messages[:content][0]).to eq("can't be blank")
    end
  end
end
