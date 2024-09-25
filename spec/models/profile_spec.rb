# == Schema Information
#
# Table name: profiles
#
#  id         :bigint           not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :bigint           not null
#
# Indexes
#
#  index_profiles_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
require 'rails_helper'

RSpec.describe Profile, type: :model do
  context '正しい情報が与えられた場合' do
    let!(:profile) { build(:profile, :with_avatar) }

    before do
      profile.save
    end

    it 'プロフィールが保存される' do
      expect(profile).to be_valid
    end
  end

  context '画像が添付されていない場合' do
    let!(:profile) { build(:profile) }

    before do
      profile.save
    end

    it '投稿が保存さない' do
      expect(profile).not_to be_valid
      expect(profile.errors.messages[:avatar][0]).to eq("can't be blank")
    end
  end

end
