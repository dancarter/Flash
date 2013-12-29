# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :card do
    front '1 + 1 = ?'
    back '2!'

    association :user, factory: :user
  end
end
