class TimelineController < ApplicationController
  before_action :authenticate_user!

  def show
    followings_user_ids = current_user.followings.pluck(:id)

    @top_posts = Post
      .where(user_id: followings_user_ids)      #フォローしている人
      .where('posts.created_at >= ?', 24.hours.ago)   #24時間以内
      .left_joins(:likes)                       #likesテーブルを追加
      .group('posts.id')                        #各postごとに集計できるようにグループ化
      .order('COUNT(likes.id) DESC, posts.created_at DESC') # likes.idの数＝いいねの数順＞作成日順に並び替え
      .limit(5)
  end
end