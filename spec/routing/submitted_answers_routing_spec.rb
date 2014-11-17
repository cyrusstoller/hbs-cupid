require "rails_helper"

RSpec.describe SubmittedAnswersController, :type => :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/submitted_answers").to route_to("submitted_answers#index")
    end

    it "routes to #new" do
      expect(:get => "/submitted_answers/new").to route_to("submitted_answers#new")
    end

    it "routes to #show" do
      expect(:get => "/submitted_answers/1").to route_to("submitted_answers#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/submitted_answers/1/edit").to route_to("submitted_answers#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/submitted_answers").to route_to("submitted_answers#create")
    end

    it "routes to #update" do
      expect(:put => "/submitted_answers/1").to route_to("submitted_answers#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/submitted_answers/1").to route_to("submitted_answers#destroy", :id => "1")
    end

  end
end
