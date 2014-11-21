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
      expect(response).to redirect_to(thanks_path)
    end

    it "should redirect to the about page if the last question is skipped" do
      q2 = FactoryGirl.create(:question)
      get 'survey', :skip => q2.to_param
      expect(response).to redirect_to(thanks_path)
    end
  end

  describe "GET 'thanks'" do
    it "returns http success" do
      get 'thanks'
      expect(response).to be_success
    end
  end

  describe "GET 'my_answers'" do
    before(:each) do
      @user = FactoryGirl.create(:user)
      sign_in @user
    end

    it "returns http success" do
      FactoryGirl.create(:submitted_answer, :user => @user)
      get 'my_answers'
      expect(response).to be_success
    end

    it "redirects to the survey when there are no answers" do
      get 'my_answers'
      expect(response).to redirect_to(survey_path)
    end
  end

  describe "GET 'matches'" do
    before(:each) do
      @user = FactoryGirl.create(:user)
      sign_in @user
    end

    it "should return http success" do
      @user2 = FactoryGirl.create(:user)
      @cr = FactoryGirl.create(:cached_percentage_result, :user1 => @user, :user2 => @user2)

      get 'matches', :username => @user.username
      expect(response).to be_success
    end

    it "should redirect if there are no results" do
      get 'matches', :username => @user.username
      expect(response).to redirect_to(root_path)
    end
  end
end
