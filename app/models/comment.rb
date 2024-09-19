# == Schema Information
#
# Table name: comments
#
#  id         :bigint           not null, primary key
#  content    :text             not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  post_id    :bigint           not null
#  user_id    :bigint           not null
#
# Indexes
#
#  index_comments_on_post_id  (post_id)
#  index_comments_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (post_id => posts.id)
#  fk_rails_...  (user_id => users.id)
#
class Comment < ApplicationRecord
  belongs_to :post
  belongs_to :user
  after_create :check_for_mentions

  validates :content, presence: true

  private
  def check_for_mentions
    mentioned_usernames = content.scan(/@([^\s@]+)/).flatten
    mentioned_users = User.where(username: mentioned_usernames)
    mentioned_users.each do |mentioned_user|
      send_mention_notification(mentioned_user)
    end
  end

  def send_mention_notification(mentioned_user)
    CommentsMailer.mention_notification(mentioned_user, self).deliver_later
  end
end
