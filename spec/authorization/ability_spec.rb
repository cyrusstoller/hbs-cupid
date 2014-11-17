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
  end

  describe "activated user" do
    let(:user) { FactoryGirl.create(:user, :active => true) }
    subject { Ability.new(user) }

    it { should be_able_to(:manage, Question) }
  end
end
