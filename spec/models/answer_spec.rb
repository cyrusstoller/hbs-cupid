require 'rails_helper'

RSpec.describe Answer, :type => :model do
  describe "validations" do
    it { expect(FactoryGirl.build(:answer)).to be_valid }
    it { expect(FactoryGirl.build(:answer, :body => nil)).to_not be_valid }
  end

  describe "database relationships" do
    it { expect(FactoryGirl.build(:answer)).to respond_to(:question) }
  end
end
