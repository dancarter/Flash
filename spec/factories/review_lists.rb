# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :review_list do
    amount 1
    new_count 0
    max 0

    association :user

    trait :srs_review do
      srs_review true
    end

    factory :srs_review_list, traits: [:srs_review]
  end
end
