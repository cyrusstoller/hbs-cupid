require 'rails_helper'
require "cancan/matchers"

RSpec.describe Ability do
  describe "Admins" do
    let(:admin) { FactoryGirl.create(:user, :admin => true) }
    subject { Ability.new(admin) }

    it { should be_able_to(:manage, :all) }
  end

  describe "User" do
    let(:user) { FactoryGirl.create(:user) }
    subject { Ability.new(user) }

    it { should_not be_able_to(:manage, Question) }
    it { should_not be_able_to(:show, Question) }
    it { should_not be_able_to(:edit, Question) }

    it { should be_able_to(:create, SubmittedAnswer) }
    it { should_not be_able_to(:show, SubmittedAnswer) }

    describe "Update Submitted Answer" do
      it "should not be able to update another user's submitted_answer" do
        sa = FactoryGirl.create(:submitted_answer, :user_id => user.id + 1)
        should_not be_able_to(:update, sa)
      end

      it "should be able to update his/her own submitted_answer" do
        sa = FactoryGirl.create(:submitted_answer, :user_id => user.id)
        should be_able_to(:edit, sa)
        should be_able_to(:update, sa)
        should_not be_able_to(:manage, sa)
      end
    end
  end

  describe "activated user" do
    let(:user) { FactoryGirl.create(:user, :active => true) }
    subject { Ability.new(user) }

    it { should be_able_to(:view_matches, user) }
    it { should_not be_able_to(:view_matches, FactoryGirl.create(:user)) }
  end
end
