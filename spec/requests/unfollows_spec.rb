require 'rails_helper'

RSpec.describe "Unfollows", type: :request do
  context 'ログインしている && プロフィール画像が設定されている場合' do
    let!(:user1) { create(:user) }
    let!(:profile1) { create(:profile, :with_avatar, user: user1 )}
    let!(:user2) { create(:user) }
    let!(:profile2) { create(:profile, :with_avatar, user: user2 )}

    before do
      sign_in user1
    end

    context 'current_userがuser2に対してアンフォローボタンを押した場合' do
      describe "POST /follows" do
        let!(:relationship) { create(:relationship, following: user2, follower: user1)}

        it "ステータスコード200 && msg: アンフォローしましたが返ってくる && フォロー関係が削除されている" do
          post api_unfollow_path(account_id: user2.id)

          expect(response).to have_http_status(200)

          body = JSON.parse(response.body)
          expect(body['msg']).to eq('アンフォローしました')

          expect(Relationship.where(follower_id: user1.id, following_id: user2.id)).to be_empty
        end
      end
    end


  end
end
