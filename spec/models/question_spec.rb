require 'rails_helper'

RSpec.describe Question, :type => :model do
  describe "validations" do
    it { expect(FactoryGirl.build(:question)).to be_valid }
    it { expect(FactoryGirl.build(:question, :text => nil)).to_not be_valid }
  end

  describe "database relationships" do
    it { expect(FactoryGirl.build(:question)).to respond_to(:answers) }
    it { expect(FactoryGirl.build(:question)).to respond_to(:submitted_answers) }
  end

  describe "scopes" do
    it { expect(Question).to respond_to(:unanswered_by) }
  end
end
