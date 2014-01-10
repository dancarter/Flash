# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :review_list do
    amount 1

    association :user
  end
end
