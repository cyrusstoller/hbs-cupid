require 'rails_helper'

describe User, :type => :model do
  describe "validations" do
    it { expect(FactoryGirl.build(:user)).to be_valid }
    
    it { expect(FactoryGirl.build(:user, :email => nil)).not_to be_valid }
    it { expect(FactoryGirl.build(:user, :email => "a s@gmail.com")).not_to be_valid }

    it { expect(FactoryGirl.build(:user, :username => nil)).not_to be_valid }
    it { expect(FactoryGirl.build(:user, :username => "")).to_not be_valid}
    it { expect(FactoryGirl.build(:user, :section => nil)).to_not be_valid}
    it { expect(FactoryGirl.build(:user, :section => "")).to_not be_valid}
  end
  
  describe "database relationships" do
    it { expect(FactoryGirl.build(:user)).to respond_to(:submitted_answers) }
    it { expect(FactoryGirl.build(:user)).to respond_to(:answered_questions) }
  end

  describe "scopes" do
    it { expect(User).to respond_to(:in_section) }
  end

  describe "class methods" do
    it "should respond to :find_by_username" do
      expect(User).to respond_to(:find_by_username)
    end
    
    it "should return the same user in both searches" do
      user = FactoryGirl.create(:user)
      expect(User.find_by_username(user.username.upcase)).to eq(user)
      expect(User.find_by_username(user.username.downcase)).to eq(user)
      expect(User.find_by_username(user.username)).to eq(user)
    end
    
    it "should raise ActiveRecord::RecordNotFound if there is no user with that username" do
      expect {
        User.find_by_username("abc")
      }.to raise_error(ActiveRecord::RecordNotFound)
    end
    
    it "should raise ActiveRecord::RecordNotFound if it is passed nil as the username" do
      expect {
        User.find_by_username(nil)
      }.to raise_error(ActiveRecord::RecordNotFound)
    end
  end

  describe "instance methods" do
  end
end
