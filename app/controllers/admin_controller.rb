class AdminController < ApplicationController
  before_action :get_user, :except => [:user_list]

  # GET /admin/user_list
  def user_list
    authorize! :user_list, User
    @title = "User List"
    @users = User.order(email: :asc)
  end

  # PATCH /admin/activate/:user_id
  def activate
    authorize! :activate, @user
    update_user_active_status(true)
    redirect_to :action => :user_list
  end

  # PATCH /admin/suspend/:user_id
  def suspend
    authorize! :suspend, @user
    update_user_active_status(false)
    redirect_to :action => :user_list
  end

  private

  def get_user
    @user = User.find(params[:user_id])
  end

  def update_user_active_status(val)
    @user.active = val
    @user.save!
  end
end
