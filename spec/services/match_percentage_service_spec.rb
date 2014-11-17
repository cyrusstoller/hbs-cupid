require 'rails_helper'

RSpec.describe MatchPercentageService do
  before(:each) do
    @user1 = FactoryGirl.create(:user)
    @user2 = FactoryGirl.create(:user)
  end

  let(:mps) { MatchPercentageService.new(@user1) }

  describe "should match the correct questions" do
    it "should work with four submitted answers but only two overlap" do
      a1 = FactoryGirl.create(:submitted_answer, :user => @user1, 
                              :question_id => 12, :answer_id => 1, :accepted_answer_ids => [1,2],
                              :intensity => 1)
      a2 = FactoryGirl.create(:submitted_answer, :user => @user1, 
                              :question_id => 13, :answer_id => 3, :accepted_answer_ids => [3,4],
                              :intensity => 1)
      a3 = FactoryGirl.create(:submitted_answer, :user => @user2, 
                              :question_id => 12, :answer_id => 2, :accepted_answer_ids => [1,2],
                              :intensity => 1)
      a4 = FactoryGirl.create(:submitted_answer, :user => @user2, 
                              :question_id => 14, :answer_id => 5, :accepted_answer_ids => [5,6],
                              :intensity => 1)
      expect(mps.compute_score(@user2)).to eq(1)
    end

    it "should work with two submitted answers without overlap" do
      a1 = FactoryGirl.create(:submitted_answer, :user => @user1, 
                              :question_id => 13, :answer_id => 3, :accepted_answer_ids => [3,4],
                              :intensity => 1)
      a2 = FactoryGirl.create(:submitted_answer, :user => @user2, 
                              :question_id => 14, :answer_id => 5, :accepted_answer_ids => [5,6],
                              :intensity => 1)
      expect(mps.compute_score(@user2)).to eq(0)
    end
  end

  describe "calculate the correct scores" do
    it "should be 0 since one of the users doesn't like the other" do
      a1 = FactoryGirl.create(:submitted_answer, :user => @user1, 
                              :question_id => 13, :answer_id => 3, :accepted_answer_ids => [3,4],
                              :intensity => 1)
      a2 = FactoryGirl.create(:submitted_answer, :user => @user2, 
                              :question_id => 13, :answer_id => 3, :accepted_answer_ids => [5],
                              :intensity => 1)
      expect(mps.compute_score(@user2)).to eq(0)
    end

    it "should be a real percentage" do
      a1 = FactoryGirl.create(:submitted_answer, :user => @user1, 
                              :question_id => 12, :answer_id => 1, :accepted_answer_ids => [1,2],
                              :intensity => 3)
      a2 = FactoryGirl.create(:submitted_answer, :user => @user1, 
                              :question_id => 13, :answer_id => 3, :accepted_answer_ids => [3,4],
                              :intensity => 1)
      a3 = FactoryGirl.create(:submitted_answer, :user => @user2, 
                              :question_id => 12, :answer_id => 2, :accepted_answer_ids => [1,2],
                              :intensity => 3)
      a4 = FactoryGirl.create(:submitted_answer, :user => @user2, 
                              :question_id => 13, :answer_id => 5, :accepted_answer_ids => [5,6],
                              :intensity => 2)
      a5 = FactoryGirl.create(:submitted_answer, :user => @user2, 
                              :question_id => 14, :answer_id => 9, :accepted_answer_ids => [11,12],
                              :intensity => 2)
      expect(mps.compute_score(@user2)).to eq(Math.sqrt(50.0/51 * 50.0/60))
    end
  end

  describe "work in edge cases" do
    it "should be 0 when there are no accepted answers" do
      a1 = FactoryGirl.create(:submitted_answer, :user => @user1, 
                              :question_id => 13, :answer_id => 3, :accepted_answer_ids => nil,
                              :intensity => 1)
      a2 = FactoryGirl.create(:submitted_answer, :user => @user2, 
                              :question_id => 13, :answer_id => 3, :accepted_answer_ids => [5],
                              :intensity => 1)
      expect(mps.compute_score(@user2)).to eq(0)
    end
  end

  describe "caching mechanism" do
    let(:a1) { 
      FactoryGirl.create(:submitted_answer, :user => @user1,
                         :question_id => 13, :answer_id => 3, :accepted_answer_ids => [3],
                         :intensity => 1)
    }
    let(:a2) {
      FactoryGirl.create(:submitted_answer, :user => @user2,
                         :question_id => 13, :answer_id => 3, :accepted_answer_ids => [3,4],
                         :intensity => 1)
    }

    it "should be 0 when there are no accepted answers" do
      mps.compute_score(@user2)
      expect(mps).to_not receive(:set_submitted_answers)
      mps.compute_score(@user2)
    end

    it "should only create one CachedPercentageResult" do
      mps.compute_score(@user2)
      mps.compute_score(@user2)
      expect(CachedPercentageResult.count).to eq(1)
    end
  end
end
