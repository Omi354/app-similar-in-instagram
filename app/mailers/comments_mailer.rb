class CommentsMailer < ApplicationMailer
  def mention_notification(mentioned_user, comment)
    @comment = comment
    @mentioned_user = mentioned_user
    @mentioning_user = @comment.user
    mail to: @mentioned_user.email, subject: '【お知らせ】メンションされました'
  end
end


# やりたいこと
# commentのinputtagのval()に@usernameの形式があれば、それを検知して、user = User.find_by(username: '@のあと') => user.emailでmail to2セットする
