FactoryGirl.define do
  sequence(:email) {|n| "person-#{n}@example.com" }
  sequence(:username) {|n| "person#{n}" }
  sequence(:uuid) {|n| "uuid#{n}"}
end