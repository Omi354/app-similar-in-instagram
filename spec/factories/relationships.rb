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
FactoryBot.define do
  factory :relationship do
    transient do
      user { create(:user) }
    end

    follower { user }
    following { create(:user) }

    after(:build) do |relationship|
      if relationship.follower == relationship.following
        relationship.following = create(:user) # 異なるユーザーを再生成
      end
    end
  end
end
