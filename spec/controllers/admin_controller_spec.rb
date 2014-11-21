require 'rails_helper'

RSpec.describe AdminController, :type => :controller do
  render_views

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

    it "returns http success" do
      get :user_list, :section => "j"
      expect(response).to be_success
    end
  end

  describe "GET section_list" do
    it "returns http success" do
      get :section_list
      expect(response).to be_success
    end
  end

  describe "PATCH activate_section" do
    let(:u_list) { FactoryGirl.create_list(:user, 3, :active => false, :section => "J") }

    it "should redirect back to the section list and set all of the users to active" do
      patch :activate_section, :section => "J"
      expect(response).to redirect_to(admin_section_list_path)
      num_active = User.in_section("J").where(:active => true).count
      expect(User.in_section("J").count).to eq(num_active)
    end
  end

  describe "PATCH deactivate_section" do
    let(:u_list) { FactoryGirl.create_list(:user, 3, :active => true, :section => "J") }

    it "should redirect back to the section list and set all of the users to active" do
      patch :deactivate_section, :section => "J"
      expect(response).to redirect_to(admin_section_list_path)
      num_active = User.in_section("J").where(:active => false).count
      expect(User.in_section("J").count).to eq(num_active)
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
