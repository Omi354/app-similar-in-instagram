require 'rails_helper'

RSpec.describe "Comments", type: :request do
  let!(:user) { create(:user) }
  let!(:sample_post) { create(:post, :with_image, user: user) }
  let!(:profile) { create(:profile, :with_avatar, user: user )}
  
  
  context 'indexにリクエストを送った場合' do
    let!(:comments) { create_list(:comment, 3, user: user, post: sample_post) }
    before do
      sign_in user
    end

    describe "GET /comments" do
      it "200ステータスが返ってくる" do
        get post_comments_path(post_id: sample_post.id)
        expect(response).to have_http_status(200)

        body = JSON.parse(response.body)
        expect(body.length).to eq(3)
        expect(body[0]['content']).to eq comments.first.content
        expect(body[1]['content']).to eq comments.second.content
        expect(body[2]['content']).to eq comments.third.content
      end
    end
  end

  context 'createにリクエストを送った場合' do
    before do
      sign_in user
    end

    describe "POST /comments" do
      it "200ステータスが返ってくる" do
        post post_comments_path(post_id: sample_post.id), params: {comment: { content: 'hogehoge', post_id: sample_post.id } }
        expect(response).to have_http_status(200)

        body = JSON.parse(response.body)
        expect(body['content']).to eq('hogehoge')
      end
    end
  end
end
