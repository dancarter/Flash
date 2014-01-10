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

    trait :with_tags do
      ignore do
        tags_count 3
      end

      after(:create) do |card, evaluator|
        evaluator.tags_count.times do
          tag = FactoryGirl.create(:tag, user: card.user)
          FactoryGirl.create(:tagging, card: card, tag: tag)
        end
      end
    end

    factory :card_with_tags, traits: [:with_tags]
  end
end
