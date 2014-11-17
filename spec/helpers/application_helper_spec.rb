require 'rails_helper'

describe ApplicationHelper, :type => :helper do
  describe "title_helper" do
    it "should return 'Cupid'" do
      @title = nil
      expect(helper.title).to eq("Cupid")
      @title = ""
      expect(helper.title).to eq("Cupid")
    end

    it "should return 'Cupid | Home'" do
      @title = "Home"
      expect(helper.title).to eq("Cupid | Home")
    end
  end
  
  describe "alert_type" do
    it "should return 'alert' when given 'error'" do
      expect(helper.alert_type("error")).to eq("alert")
      expect(helper.alert_type(:error)).to eq("alert")
    end

    it "should return 'warning' when given 'notice'" do
      expect(helper.alert_type("notice")).to eq("warning")
      expect(helper.alert_type(:notice)).to eq("warning")
    end

    it "should return 'success' when given 'success'" do
      expect(helper.alert_type("success")).to eq("success")
      expect(helper.alert_type(:success)).to eq("success")
    end
  end
end

