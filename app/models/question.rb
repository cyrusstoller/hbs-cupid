# == Schema Information
# Schema version: 20141106021114
#
# Table name: questions
#
#  id          :integer          not null, primary key
#  text        :string(255)
#  background  :text
#  category_id :integer
#  created_at  :datetime
#  updated_at  :datetime
#

class Question < ActiveRecord::Base
  validates_presence_of :text
  validate :validate_num_answers

  has_many :answers, -> { order(id: :asc) }, :dependent => :destroy
  accepts_nested_attributes_for :answers, allow_destroy: true, reject_if: -> (i) { i['body'].blank? }

  has_many :submitted_answers, :dependent => :destroy

  scope :unanswered_by, -> (user) {
    sql_query = %Q{
      LEFT JOIN "submitted_answers" on "questions"."id" = "submitted_answers"."question_id"
      AND "submitted_answers"."user_id" = #{user.id}
    }
    joins(sql_query).where(%("submitted_answers"."id" IS NULL)).order("RANDOM()")
  }

  attr_accessor :skip_association_validation

  private

  def validate_num_answers
    num_answers = 2

    if self.answers.reject(&:marked_for_destruction?).length < num_answers && !@skip_association_validation
      self.errors["base"] << "Must have at least #{num_answers} answers"
    end
  end
end
