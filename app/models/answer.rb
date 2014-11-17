# == Schema Information
# Schema version: 20141106200853
#
# Table name: answers
#
#  id          :integer          not null, primary key
#  question_id :integer
#  body        :string(255)
#  created_at  :datetime
#  updated_at  :datetime
#
# Indexes
#
#  index_answers_on_question_id  (question_id)
#

class Answer < ActiveRecord::Base
  validates_presence_of :body

  belongs_to :question
end
