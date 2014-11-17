json.array!(@submitted_answers) do |submitted_answer|
  json.extract! submitted_answer, :id, :user_id, :question_id, :answer_id, :accepted_answer_ids, :intensity, :comment
  json.url submitted_answer_url(submitted_answer, format: :json)
end
