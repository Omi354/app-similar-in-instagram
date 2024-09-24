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

    describe "PUT /profile" do
      let!(:avatar_path) { Rails.root.join('app/assets/images/default_avatar.png') }
      let!(:avatar_file) { fixture_file_upload(avatar_path, 'image/png') }

      it "200ステータス && 成功時のメッセージが取得される" do
        put profile_path, params: { profile: { avatar: [avatar_file] } }
        expect(response).to have_http_status(200)
        body = JSON.parse(response.body)
        expect(body['message']).to eq('Profile updated successfully')
      end
    end

    describe "GET /profile/edit" do
      it "200ステータス && hasAvatar: true && avatar_ulr が返ってくる" do
        get edit_profile_path

        expect(response).to have_http_status(200)

        body = JSON.parse(response.body)
        expect(body['hasAvatar']).to eq(true)
        expect(body['avatarUrl']).to include('sample_avatar1.jpg')
      end
    end
  end

  context 'ログインしている && アバターが設定されていない場合' do
    let!(:user) { create(:user) }

    before do
      sign_in user
    end

    describe "GET /profile/edit" do
      it "200ステータス && hasAvatar: false が返ってくる" do
        get edit_profile_path

        expect(response).to have_http_status(200)

        body = JSON.parse(response.body)
        expect(body['hasAvatar']).to eq(false)
      end
    end
  end
end

