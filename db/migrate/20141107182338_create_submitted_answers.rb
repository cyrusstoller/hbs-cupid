class CreateSubmittedAnswers < ActiveRecord::Migration
  def change
    create_table :submitted_answers do |t|
      t.integer :user_id
      t.integer :question_id
      t.integer :answer_id
      t.integer :accepted_answer_ids, array: true
      t.integer :intensity
      t.text    :comment

      t.timestamps
    end

    add_index :submitted_answers, :user_id
    add_index :submitted_answers, :question_id
    add_index :submitted_answers, :answer_id
    add_index :submitted_answers, :accepted_answer_ids, using: :gin
  end
end
