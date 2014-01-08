# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :card do
    sequence :front do |n|
      "1 + #{n}?"
    end
    sequence :back do |n|
      "#{n + 1}"
    end

    association :user
  end
end
