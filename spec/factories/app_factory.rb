FactoryGirl.define do

  factory :user, class: User do
    sequence :email do |n|
      "user#{n}@example.com"
    end
    password              "123456"
    password_confirmation "123456"

    trait :fully_loaded do
      after(:create) do |user, evaluator|
        create_list(:friend, 2, user: user)
        create_list(:group,  2, user: user)
        create_list(:friend, 2, user: user, group: user.reload.groups.first)
        create_list(:tweet,  2, user: user, friend_twitter_id: user.reload.friends.first.twitter_id)
        create_list(:tweet,  2, user: user, friend_twitter_id: user.reload.friends.last.twitter_id)
      end
    end
  end

  factory :friend, class: Friend do
    sequence :name do |n|
      "friend#{n}"
    end
    sequence(:twitter_id, 1000)
  end

  factory :group, class: Group do
    sequence :name do |n|
      "group#{n}"
    end
  end

  factory :tweet, class: Tweet do
    sequence(:id, 10000)
    sequence :full_text do |n|
      "tweet#{n}"
    end
  end

end
