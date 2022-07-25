FactoryBot.define do
  factory :comment do
    sequence(:text) { |n| "Lorem comment ipsum ##{ n }" }
    association :user
    association :post
  end
end
