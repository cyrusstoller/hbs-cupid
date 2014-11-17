# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :submitted_answer do
    user_id 1
    question_id 1
    answer_id 1
    accepted_answer_ids [1,2]
    intensity 1
    comment "my comment"
  end
end
