# == Schema Information
#
# Table name: posts
#
#  id         :bigint           not null, primary key
#  caption    :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :bigint           not null
#
# Indexes
#
#  index_posts_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
require 'rails_helper'

RSpec.describe Post, type: :model do
  context '正しい情報が与えられた場合' do
    let!(:post) { build(:post, :with_image) }

    before do
      post.save
    end

    it '投稿が保存される' do
      expect(post).to be_valid
    end
  end

  context 'captionがブランクの場合' do
    let!(:post) { build(:post, :with_image, caption: '') }

    before do
      post.save
    end

    it '投稿が保存される' do
      expect(post).to be_valid
    end
  end

  context '画像が添付されていない場合' do
    let!(:post) { build(:post) }

    before do
      post.save
    end

    it '投稿が保存さない' do
      expect(post).not_to be_valid
      expect(post.errors.messages[:images][0]).to eq("can't be blank")

    end
  end

  context '複数の画像が添付されている場合' do
    let!(:post) { build(:post) }

    before do
      post.images.attach(
        io: File.open(Rails.root.join('app/assets/images/arror.png')),
        filename: 'arror.png',
        content_type: 'image/png'
      )
      post.images.attach(
        io: File.open(Rails.root.join('app/assets/images/default_avatar.png')),
        filename: 'default_avatar.png',
        content_type: 'image/png'
      )
      post.images.attach(
        io: File.open(Rails.root.join('app/assets/images/auth_image.jpg')),
        filename: 'auth_image.jpg',
        content_type: 'image/jpg'
      )
      post.save
    end

    it '投稿が保存される' do
      expect(post).to be_valid
      expect(post.images.count).to eq(3)
    end
  end  

end
