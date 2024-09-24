require 'rails_helper'

RSpec.describe "Posts", type: :request do
  let!(:user) { create(:user) }
  let!(:posts) { create_list(:post, 5, :with_image, user: user) }

  context 'ログインしている&&プロフィールが設定されている状態でルートページに遷移する場合' do
    let!(:profile) { create(:profile, :with_avatar, user: user) }
    before do
      sign_in user
    end

    describe "GET /posts" do
      it "200ステータスが返ってくる" do
        get posts_path
        expect(response).to have_http_status(200)
      end
    end
  end

  context 'ログインしていない状態でルートページに遷移する場合' do
    let!(:profile) { create(:profile, :with_avatar, user: user) }

    describe "GET /posts" do
      it "ログインページにリダイレクトされる" do
        get posts_path
        expect(response).to redirect_to(new_user_session_path)
        expect(response).to have_http_status(302)
      end
    end
  end

  context 'プロフィール画像が設定されていない状態でルートページに遷移する場合' do
    before do
      sign_in user
    end

    describe "GET /posts" do
      it "プロフィールページにリダイレクトされる" do
        get posts_path
        expect(response).to redirect_to(profile_path)
        expect(response).to have_http_status(302)
      end
    end
  end

  context 'ログインしている&&プロフィールが設定されている状態で投稿ページに遷移する場合' do
    let!(:profile) { create(:profile, :with_avatar, user: user) }
    before do
      sign_in user
    end

    describe "GET /posts" do
      it "200ステータスが返ってくる" do
        get new_post_path
        expect(response).to have_http_status(200)
      end
    end
  end

  context 'ログインしている&&プロフィールが設定されている状態でコメント詳細ページに遷移する場合' do
    let!(:profile) { create(:profile, :with_avatar, user: user) }
    before do
      sign_in user
    end

    describe "GET /post" do
      it "200ステータスが返ってくる" do
        get post_path(id: posts[0])
        expect(response).to have_http_status(200)
      end
    end
  end

  context 'ログインしている&&プロフィールが設定されている状態で記事を投稿する場合' do
    let!(:profile) { create(:profile, :with_avatar, user: user) }
    let!(:image_path) { Rails.root.join('app/assets/images/arror.png') }
    let!(:image_file) { fixture_file_upload(image_path, 'image/png') }

    before do
      sign_in user
    end

    describe "post /post" do
      it "ポストが作成され、ルートページに遷移する" do
        post posts_path, params: { post: { caption: 'hogehoge', images: [image_file] } }
        expect(response).to redirect_to(root_path)

        post = Post.last
        expect(post.caption).to eq('hogehoge')
        expect(post.images.attached?).to be true

      end
    end
  end

  context 'ログインしている&&プロフィールが設定されている状態で、投稿の保存が失敗する場合' do
    let!(:profile) { create(:profile, :with_avatar, user: user) }
    let!(:new_post) { build(:post) }

    before do
      sign_in user
    end

    describe "post /post" do
      it "保存に失敗し、newテンプレートがレンダリングされる" do
        post posts_path, params: { post: { caption: new_post.caption } }
        expect(response).to have_http_status(200)
        expect(response.body).to include('Failed to create the post')
        expect(response.body).to include('Status')

      end
    end
  end
end
