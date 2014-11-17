class MatchPercentageService
  # http://www.okcupid.com/help/match-percentages
  # http://isomorphism.es/post/13178732106/okcupid-whats-wrong-match-algorithm

  attr_reader :user1, :user2
  attr_reader :score1, :score2
  attr_reader :final_score

  def initialize(user1)
    @user1 = user1
  end

  def compute_score(user2, skip_cache = false)
    @user2 = user2
    
    reset_score
    return @final_score if valid_cache_entry?(skip_cache)

    set_submitted_answers
    calculate_raw_scores
    set_final_scores

    return @final_score
  end

  private

  def reset_score
    @score1_n, @score1_d = 0, 0
    @score2_n, @score2_d = 0, 0
  end

  def valid_cache_entry?(skip_cache)
    c = CachedPercentageResult.find_instance_with_users(@user1, @user2)
    return if c.nil?

    if c.updated_at > 5.minutes.ago
      @final_score = c.final_score
      @score1 = c.score1
      @score2 = c.score2
      return true
    end
  end

  def set_submitted_answers
    @submitted_answers_1 = @user1.submitted_answers.order(question_id: :asc).to_a
    @submitted_answers_2 = @user2.submitted_answers.order(question_id: :asc).to_a
  end

  def calculate_raw_scores
    @submitted_answers_1.each do |answer1|
      return if @submitted_answers_2.empty?

      if @submitted_answers_2.first.question_id == answer1.question_id
        add_to_scores(answer1, @submitted_answers_2.shift)
      end
    end
  end

  def add_to_scores(answer1, answer2)
    intensity1 = SubmittedAnswer.intensity_coefficient[answer1.intensity]
    @score1_d += intensity1
    intensity2 = SubmittedAnswer.intensity_coefficient[answer2.intensity]
    @score2_d += intensity2

    if (answer1.accepted_answer_ids.include?(answer2.answer_id) rescue false)
      @score2_n += intensity2
    end

    if (answer2.accepted_answer_ids.include?(answer1.answer_id) rescue false)
      @score1_n += intensity1
    end
  end

  def set_final_scores
    @score1 = @score1_n / @score1_d.to_f
    @score2 = @score2_n / @score2_d.to_f

    @score1 = 0 if @score1.nan?
    @score2 = 0 if @score2.nan?

    @final_score = Math.sqrt(@score1 * @score2)

    set_cache
  end

  def set_cache
    c = CachedPercentageResult.find_instance_with_users(@user1, @user2)
    c = CachedPercentageResult.new if c.nil?

    c.user1 = @user1
    c.user2 = @user2
    c.score1 = @score1
    c.score2 = @score2
    c.final_score = @final_score
    c.save
  end
end
