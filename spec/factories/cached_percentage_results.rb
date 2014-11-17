# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :cached_percentage_result do
    user1_id 1
    user2_id 2
    score1 0.9
    score2 0.8
    final_score 0.72
  end
end
