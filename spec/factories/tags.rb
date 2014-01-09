# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :tag do
    sequence :name do |n|
      "Ruby#{n}"
    end
    share false

    association :user
  end
end
