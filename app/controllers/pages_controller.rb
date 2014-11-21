class PagesController < ApplicationController
  before_action :authenticate_user!, only: [:survey, :my_answers, :matches]

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
      redirect_to :action => :thanks
      return
    end

    @num_answers = current_user.submitted_answers.count + 1
    @num_questions = Question.count
    @progress_percentage = (@num_answers.to_f / @num_questions * 100).to_i

    @submitted_answer = current_user.submitted_answers.build(:question_id => @question.id,
                                                             :answer_id => (@question.answers.first.id rescue nil),
                                                             :intensity => 3)
  end

  def thanks
    @title = "Thanks"
  end

  def my_answers
    @title = "My Answers"
    @submitted_answers = current_user.submitted_answers.includes(:question => :answers).includes(:answer).paginate(:page => params[:page])
    if @current_user.submitted_answers.count == 0
      flash[:notice] = "You need to answer some questions first!"
      redirect_to :action => :survey
    end
  end

  def matches
    @user = User.find_by_username(params[:username])
    @title = "Matches for #{@user.username}"
    @cached_results = CachedPercentageResult.find_with_user(@user).order(final_score: :desc).limit(30)

    if @cached_results.empty?
      flash[:notice] = "Sorry your matches have not been calculated yet."
      redirect_to root_path
    end
  end
end
