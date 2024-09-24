require 'rails_helper'

RSpec.describe 'Accounts', type: :request do
  let!(:user1) { create(:user) }
  let!(:user2) { create(:user) }
  let!(:profile1) { create(:profile, :with_avatar, user: user1) }
  let!(:profile2) { create(:profile, :with_avatar, user: user2) }

  context 'アカウント詳細ページに遷移した場合' do
    before do 
      sign_in user1
    end
    describe 'GET /accounts' do
      it '200ステータスが返ってくる' do
        get account_path(user2)
        expect(response).to have_http_status(200)
      end
    end
  end

  context '自身のアカウント詳細ページに遷移した場合' do
    before do 
      sign_in user1
    end
    describe 'GET /accounts' do
      it 'profileページに遷移する' do
        get account_path(user1)
        expect(response).to have_http_status(302)

        follow_redirect!
        expect(response.body).to include('アバターをアップロード')
      end
    end
  end
end
