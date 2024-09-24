require 'rails_helper'

RSpec.describe "Follows", type: :request do
  context 'ログインしている && プロフィール画像が設定されている場合' do
    let!(:user1) { create(:user) }
    let!(:profile1) { create(:profile, :with_avatar, user: user1 )}
    let!(:user2) { create(:user) }
    let!(:profile2) { create(:profile, :with_avatar, user: user2 )}

    before do
      sign_in user1
    end

    context 'current_userがuser2をフォローしていない場合' do
      describe "GET /follows" do

        it "ステータスコード200 && follow: falseが返ってくる" do
          get api_follow_path(account_id: user2.id)
          expect(response).to have_http_status(200)
          body = JSON.parse(response.body)
          expect(body['follow']).to eq(false)
        end
      end
    end

    context 'current_userがuser2をフォローしている場合' do
      describe "GET /follows" do
        let!(:relationship) { create(:relationship, following: user2, follower: user1)}

        it "ステータスコード200 && follow: trueが返ってくる" do
          get api_follow_path(account_id: user2.id)
          expect(response).to have_http_status(200)
          body = JSON.parse(response.body)
          expect(body['follow']).to eq(true)
        end
      end
    end

    context 'current_userがuser2に対してフォローボタンを押した場合' do
      describe "POST /follows" do
        it "ステータスコード200 && msg: フォローしましたが返ってくる && フォロー関係が作成されている" do
          post api_follow_path(account_id: user2.id)

          expect(response).to have_http_status(200)

          body = JSON.parse(response.body)
          expect(body['msg']).to eq('フォローしました')

          expect(user1.followings.last.id).to eq(user2.id)
        end
      end
    end


  end
end
