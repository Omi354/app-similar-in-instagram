require 'rails_helper'

RSpec.describe "Profiles", type: :request do
  context 'ログインしている && アバターが設定されている場合' do
    let!(:user) { create(:user) }
    let!(:profile) { create(:profile, :with_avatar, user: user) }

    before do
      sign_in user
    end

    describe "GET /profile" do
      it "200ステータス && current_userの情報が表示される" do
        get profile_path
        expect(response).to have_http_status(200)

        expect(response.body).to include(user.username)
      end
    end

  end
  
end
