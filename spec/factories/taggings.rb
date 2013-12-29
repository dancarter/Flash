# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :tagging do
    association :card, factory: :card
    association :tag, factory: :tag
  end
end
