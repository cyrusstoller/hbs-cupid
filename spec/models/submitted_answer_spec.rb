require 'rails_helper'

RSpec.describe SubmittedAnswer, :type => :model do
  describe "validations" do
    it { expect(FactoryGirl.build(:submitted_answer)).to be_valid }
    it { expect(FactoryGirl.build(:submitted_answer, :user_id => nil)).to_not be_valid }
    it { expect(FactoryGirl.build(:submitted_answer, :question_id => nil)).to_not be_valid }
    it { expect(FactoryGirl.build(:submitted_answer, :answer_id => nil)).to_not be_valid }
    it { expect(FactoryGirl.build(:submitted_answer, :intensity => -1)).to_not be_valid }
  end

  describe "database relationships" do
    it { expect(FactoryGirl.build(:submitted_answer)).to respond_to(:user) }
  end
end
