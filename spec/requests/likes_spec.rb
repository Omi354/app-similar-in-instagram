require 'rails_helper'

RSpec.describe 'Likes', type: :request do
  context 'ログインしている場合'  do
    let!(:user) { create(:user) }
    let!(:profile) { create(:profile, :with_avatar, user: user) }
    let!(:test_post) { create(:post, :with_image, user: user) }

    before do
      sign_in user
    end

    describe 'GET /api/posts/:post_id/like' do
      context 'いいねをしている場合' do
        let!(:like) { create(:like, user: user, post: test_post) }
        it '200ステータス && has_like: true が返ってくる' do
          get api_like_path(post_id: test_post.id)
          expect(response).to have_http_status(200)

          body = JSON.parse(response.body)
          expect(body['has_like']).to eq(true)
        end
      end


      context 'いいねをしていない場合' do
        it '200ステータス && has_like: false が返ってくる' do
          get api_like_path(post_id: test_post.id)
          expect(response).to have_http_status(200)

          body = JSON.parse(response.body)
          expect(body['has_like']).to eq(false)
        end
      end
    end

    describe 'POST /api/posts/:post_id/like' do
      it '200ステータス && has_like: true && likeが作成されている' do
        post api_like_path(post_id: test_post.id), params: { like: { post_id: test_post.id } }
        expect(response).to have_http_status(200)

        body = JSON.parse(response.body)
        expect(body['has_like']).to eq(true)

        new_like = Like.where(user_id: user.id, post_id: test_post.id)
        expect(new_like.exists?).to eq(true)
      end
    end

    describe 'DELETE /api/posts/:post_id/like' do
      let!(:like) { create(:like, user: user, post: test_post) }
      it '200ステータス && has_like: false && likeが削除されている' do
        delete api_like_path(post_id: test_post.id)

        expect(response).to have_http_status(200)

        body = JSON.parse(response.body)
        expect(body['has_like']).to eq(false)

        deleted_like = Like.where(user_id: user.id, post_id: test_post.id)
        expect(deleted_like.exists?).to eq(false)
      end
    end

  end
end
