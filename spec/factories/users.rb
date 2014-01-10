# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    sequence :username do |n|
      "Th#{n}Us#{n}r"
    end
    sequence :email do |n|
      "fake#{n}@real.com"
    end
    password 'passw0rd'
    password_confirmation 'passw0rd'
    confirmed_at Time.now

    trait :unconfirmed do
      confirmed_at nil
    end

    factory :unconfirmed_user, traits: [:unconfirmed]
  end

end
