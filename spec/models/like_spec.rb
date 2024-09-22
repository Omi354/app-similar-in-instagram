# == Schema Information
#
# Table name: likes
#
#  id         :bigint           not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  post_id    :bigint           not null
#  user_id    :bigint           not null
#
# Indexes
#
#  index_likes_on_post_id              (post_id)
#  index_likes_on_user_id              (user_id)
#  index_likes_on_user_id_and_post_id  (user_id,post_id) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (post_id => posts.id)
#  fk_rails_...  (user_id => users.id)
#
require 'rails_helper'

RSpec.describe Like, type: :model do
  context '正しい情報が与えられた場合' do
    let!(:user) { create(:user) }
    let!(:post) { create(:post, :with_image) }
    let!(:like) { build(:like, user: user, post: post) }

    before do
      puts like.post.inspect
      like.save
    end

    it 'いいねされる' do
      expect(like).to be_valid
    end
  end

  context '同じポストにいいねしようとした場合' do
    let!(:user) { create(:user) }
    let!(:post) { create(:post, :with_image) }

    let!(:like1) { create(:like, user: user, post: post) }
    let!(:like2) { build(:like, user: user, post: post) }

    before do
      like2.save
    end

    it 'いいねされない' do
      expect(like2).not_to be_valid
      expect(like2.errors[:user_id]).to include("has already been taken")
    end
  end


end
