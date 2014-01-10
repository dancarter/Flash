# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :review_list_tag do
    association :review_list
    association :tag
  end
end
