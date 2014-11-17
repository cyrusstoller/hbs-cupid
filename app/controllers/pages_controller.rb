class PagesController < ApplicationController
  before_action :authenticate_user!, only: [:survey]

  def welcome
    @title = "Welcome"
    session["user_return_to"] = survey_path
  end

  def about
    @title = "About"
  end

  def survey
    @title = "Survey"

    if params[:skip].blank?
      @question = Question.unanswered_by(current_user).limit(1).first
    else
      flash[:notice] = "Question skipped!"
      @question = Question.unanswered_by(current_user).where.not(:id => params[:skip]).limit(1).first
    end

    if @question.nil?
      flash[:info] = "You've answered all of our survey questions!"
      redirect_to :action => :about
      return
    end

    @num_answers = current_user.submitted_answers.count + 1
    @num_questions = Question.count
    @progress_percentage = (@num_answers.to_f / @num_questions * 100).to_i

    @submitted_answer = current_user.submitted_answers.build(:question_id => @question.id,
                                                             :answer_id => (@question.answers.first.id rescue nil),
                                                             :intensity => 3)
  end
end
