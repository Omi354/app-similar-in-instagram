module PostsHelper
  def show_posttime(post)
    if post.created_at.to_date == Date.today
      time_ago_in_words(post.created_at) + ' ago'
    else
      post.created_at.strftime('%m/%d, %Y')
    end
  end
end