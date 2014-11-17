require 'rails_helper'

describe PagesController, :type => :controller do
  render_views
  
  describe "GET 'welcome'" do
    describe "signed_in" do
      before(:each) do
        @user = FactoryGirl.create(:user)
        sign_in @user
      end

      it "should be success" do
        get 'welcome'
        expect(response).to be_success
      end
    end

    describe "not signed in" do
      it "returns http success" do
        get 'welcome'
        expect(response).to be_success
      end
    end
  end
  
  describe "GET 'about'" do
    it "returns http success" do
      get 'about'
      expect(response).to be_success
    end
  end

  describe "GET 'survey'" do
    before(:each) do
      @user = FactoryGirl.create(:user)
      sign_in @user
    end

    it "returns http success" do
      FactoryGirl.create(:question)
      get 'survey'
      expect(response).to be_success
    end

    it "returns http success if there is a skip" do
      q1 = FactoryGirl.create(:question)
      q2 = FactoryGirl.create(:question)
      get 'survey', :skip => q2.to_param
      expect(response).to be_success
    end

    it "redirects to the about page" do
      get 'survey'
      expect(response).to redirect_to(about_path)
    end

    it "should redirect to the about page if the last question is skipped" do
      q2 = FactoryGirl.create(:question)
      get 'survey', :skip => q2.to_param
      expect(response).to redirect_to(about_path)
    end
  end
end
