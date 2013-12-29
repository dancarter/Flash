# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    username 'TheUser'
    email 'fake@real.com'
    encrypted_password '$2a$10$3shmtWIkLjXPhBWwZ6qlVelCO1NmI9KHsUmX35zrrlDVhjV4GEppC'
  end
end
