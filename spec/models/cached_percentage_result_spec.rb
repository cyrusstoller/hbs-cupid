require 'rails_helper'

RSpec.describe CachedPercentageResult, :type => :model do
  describe "validations" do
    it { expect(FactoryGirl.build(:cached_percentage_result, :user1_id => nil)).to_not be_valid }
    it { expect(FactoryGirl.build(:cached_percentage_result, :user2_id => nil)).to_not be_valid }
    it { expect(FactoryGirl.build(:cached_percentage_result, :user1_id => 1, :user2_id => 1)).to_not be_valid }

    it "should validate the uniqueness of the pairs" do
      FactoryGirl.create(:cached_percentage_result, :user1_id => 1, :user2_id => 2)
      cpr = FactoryGirl.build(:cached_percentage_result, :user1_id => 1, :user2_id => 2)
      expect(cpr).to_not be_valid
    end

    it "should reorder the user ids" do
      cpr = FactoryGirl.build(:cached_percentage_result, :user1_id => 3, :user2_id => 1, :score1 => 2, :score2 => 1)
      cpr.valid?
      expect(cpr.user1_id).to eq(1)
      expect(cpr.user2_id).to eq(3)
      expect(cpr.score1).to eq(1)
      expect(cpr.score2).to eq(2)
    end
  end

  describe "database relationships" do
    it { expect(FactoryGirl.build(:cached_percentage_result)).to respond_to(:user1) }
    it { expect(FactoryGirl.build(:cached_percentage_result)).to respond_to(:user2) }
  end

  describe "class methods" do
    describe "find_with_user" do
      it "should return all of the records with a user in either user1_id or user2_id" do
        u = FactoryGirl.create(:user)
        r1 = FactoryGirl.create(:cached_percentage_result, :user1 => u)
        r2 = FactoryGirl.create(:cached_percentage_result, :user2 => u)
        r3 = FactoryGirl.create(:cached_percentage_result, :user1_id => -1, :user2_id => -2)
        expect(CachedPercentageResult.find_with_user(u)).to include(r1)
        expect(CachedPercentageResult.find_with_user(u)).to include(r2)
        expect(CachedPercentageResult.find_with_user(u)).to_not include(r3)

        expect(CachedPercentageResult.find_with_user(u.id)).to include(r1)
        expect(CachedPercentageResult.find_with_user(u.id)).to include(r2)
        expect(CachedPercentageResult.find_with_user(u.id)).to_not include(r3)
      end
    end

    describe "find_instance_with_users" do
      it "should return an instance for the two users" do
        u1 = FactoryGirl.create(:user)
        u2 = FactoryGirl.create(:user)
        r1 = FactoryGirl.create(:cached_percentage_result, :user1 => u1, :user2 => u2)
        r2 = FactoryGirl.create(:cached_percentage_result, :user1 => u1, :user2_id => -1)

        expect(CachedPercentageResult.find_instance_with_users(u1, u2)).to eq(r1)
      end
    end
  end
end
