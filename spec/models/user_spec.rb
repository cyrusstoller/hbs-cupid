require 'rails_helper'

describe User, :type => :model do
  describe "validations" do
    it { expect(FactoryGirl.build(:user)).to be_valid }
    
    it { expect(FactoryGirl.build(:user, :email => nil)).not_to be_valid }
    it { expect(FactoryGirl.build(:user, :email => "a s@gmail.com")).not_to be_valid }

    it { expect(FactoryGirl.build(:user, :username => nil)).not_to be_valid }
    it { expect(FactoryGirl.build(:user, :username => "")).to_not be_valid}
  end
  
  describe "database relationships" do
    it { expect(FactoryGirl.build(:user)).to respond_to(:submitted_answers) }
    it { expect(FactoryGirl.build(:user)).to respond_to(:answered_questions) }
  end

  describe "class methods" do
  end

  describe "instance methods" do
  end
end
