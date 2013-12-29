# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    username 'TheUser'
    email 'fake@real.com'
    password 'passw0rd'
  end
end
