require 'rails_helper'

RSpec.describe "Followers", type: :request do

  context 'ログインしている&&プロフィール画像が設定されている場合' do
    let!(:user1) { create(:user) }
    let!(:profile1) { create(:profile, :with_avatar, user: user1 )}
    
    before do
      sign_in user1
    end
    
    describe "GET /followers" do
      let!(:user2) { create(:user) }
      let!(:profile2) { create(:profile, :with_avatar, user: user2 )}
      let!(:relationship) { create(:relationship, following: user1, follower: user2)}

      it "ステータスコード200が返ってくる" do
        get account_follower_path(account_id: user1.id)
        expect(response).to have_http_status(200)
        expect(response.body).to include(user2.username)
      end
    end

  end

end
