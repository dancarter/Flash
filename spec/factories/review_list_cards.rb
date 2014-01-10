# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :review_list_card do
    association :review_list
    association :card
  end
end
