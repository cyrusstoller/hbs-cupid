require 'rails_helper'

RSpec.describe AdminController, :type => :controller do
  let(:user) { FactoryGirl.create(:user) }

  before(:each) do
    @user = FactoryGirl.create(:user, :admin => true)
    sign_in @user
  end

  describe "GET user_list" do
    it "returns http success" do
      get :user_list
      expect(response).to be_success
    end
  end

  describe "PATCH activate" do
    it "redirects to the user list" do
      patch :activate, :user_id => user.id
      expect(response).to redirect_to(:action => :user_list)

      user.reload
      expect(user.active).to eq(true)
    end
  end

  describe "PATCH suspend" do
    it "redirects to the user list" do
      patch :suspend, :user_id => user.id
      expect(response).to redirect_to(:action => :user_list)

      user.reload
      expect(user.active).to eq(false)
    end
  end

end
