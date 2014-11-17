# == Schema Information
# Schema version: 20141107182338
#
# Table name: submitted_answers
#
#  id                  :integer          not null, primary key
#  user_id             :integer
#  question_id         :integer
#  answer_id           :integer
#  accepted_answer_ids :integer          is an Array
#  intensity           :integer
#  comment             :text
#  created_at          :datetime
#  updated_at          :datetime
#
# Indexes
#
#  index_submitted_answers_on_accepted_answer_ids  (accepted_answer_ids)
#  index_submitted_answers_on_answer_id            (answer_id)
#  index_submitted_answers_on_question_id          (question_id)
#  index_submitted_answers_on_user_id              (user_id)
#

class SubmittedAnswer < ActiveRecord::Base
  validates_presence_of :user_id
  validates_presence_of :question_id
  validates_presence_of :answer_id
  validates_numericality_of :intensity, :greater_than_or_equal_to => 0

  belongs_to :user, :class_name => "User", :foreign_key => "user_id"
  belongs_to :question
  belongs_to :answer

  before_validation -> { self.accepted_answer_ids ||= [] }

  def accepted_answers_params=(answer_ids)
    self.accepted_answer_ids = answer_ids.map(&:to_i)
  end

  def self.intensity_text
    {
      0 => "Irrelevant",
      1 => "A little important",
      2 => "Somewhat important",
      3 => "Very important",
      4 => "Deal breaker"
    }
  end

  def self.intensity_coefficient
    {
      0 => 0,
      1 => 1,
      2 => 10,
      3 => 50,
      4 => 250
    }    
  end
end
