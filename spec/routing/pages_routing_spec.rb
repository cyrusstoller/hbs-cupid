require 'rails_helper'

describe PagesController, :type => :routing do
  describe "routing" do
    
    it "routes to the about page" do
      expect(get("/about")).to route_to("pages#about")
    end

    it "routes to the survey page" do
      expect(get("/survey")).to route_to("pages#survey")
    end

  end
end