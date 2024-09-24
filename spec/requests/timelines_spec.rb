require 'rails_helper'

RSpec.describe "Timelines", type: :request do
  context 'ログインしている && アバターが登録されている場合' do
    let!(:user) { create(:user) }
    let!(:profile) { create(:profile, :with_avatar, user: user) }

    before do
      sign_in user
    end

    describe "GET /timeline" do
      it "200ステータスが返ってくる" do
        get timeline_path
        expect(response).to have_http_status(200)
      end
    end
  end
  
end
