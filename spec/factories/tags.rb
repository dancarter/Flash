# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :tag do
    sequence :name do |n|
      "Ruby#{n}"
    end
    share true

    association :user
  end
end
