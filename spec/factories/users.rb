# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    email
    password  "foobar12"
    username
    section "J"
  end
end
