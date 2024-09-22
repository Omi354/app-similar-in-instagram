# == Schema Information
#
# Table name: posts
#
#  id         :bigint           not null, primary key
#  caption    :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :bigint           not null
#
# Indexes
#
#  index_posts_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
FactoryBot.define do
  factory :post do
    caption { Faker::Lorem.characters(number: 50) }
    association :user

    trait :with_image do
      after(:build) do |post|
        post.images.attach(
          io: File.open(Rails.root.join('app/assets/images/arror.png')),
          filename: 'arror.png',
          content_type: 'image/png'
        )
      end
    end
  end
end
