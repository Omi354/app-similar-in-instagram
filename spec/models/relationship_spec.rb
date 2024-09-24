# == Schema Information
#
# Table name: relationships
#
#  id           :bigint           not null, primary key
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  follower_id  :bigint           not null
#  following_id :bigint           not null
#
# Indexes
#
#  index_relationships_on_follower_id                   (follower_id)
#  index_relationships_on_follower_id_and_following_id  (follower_id,following_id) UNIQUE
#  index_relationships_on_following_id                  (following_id)
#
# Foreign Keys
#
#  fk_rails_...  (follower_id => users.id)
#  fk_rails_...  (following_id => users.id)
#
require 'rails_helper'

RSpec.describe Relationship, type: :model do
  context '正しい情報が与えられた場合' do
    let!(:relationship) { build(:relationship) }

    before do
      relationship.save
    end

    it 'フォローの関係が作られる' do
      expect(relationship).to be_valid
    end
  end

  context '同じフォロワーとフォロイングの組み合わせが存在する場合' do
    let!(:user1) { create(:user) }
    let!(:user2) { create(:user) }
    let!(:existing_relationship) { create(:relationship, follower: user1, following: user2) }
    let!(:new_relationship) { build(:relationship, follower: user1, following: user2) }

 
    it 'フォロー関係が作成されない' do
      new_relationship.save
      expect(new_relationship).not_to be_valid
      expect(new_relationship.errors[:follower_id]).to include("has already been taken")
    end
  end

end
