# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :question do
    text "MyString"
    background "MyText"
    category_id 1
    skip_association_validation true

    ignore do
      answer_count 5
    end

    after(:create) do |question, evaluator|
      FactoryGirl.create_list(:answer, evaluator.answer_count, question: question)
    end
  end
end
