class AdminController < ApplicationController
  before_action :get_user, :except => [:user_list, :section_list, :activate_section, :deactivate_section]

  # GET /admin/user_list
  def user_list
    authorize! :user_list, User
    @title = "User List"

    if params[:section].present?
      @users = User.order(id: :desc).in_section(params[:section]).paginate(:page => params[:page])
    else
      @users = User.order(email: :asc).paginate(:page => params[:page])
    end
  end

  # GET /admin/section_list
  def section_list
    authorize! :section_list, User
    @title = "Section List"
    @section_count = User.order(section: :asc).group(:section).count
  end

  # PATCH /admin/activate_section/:section
  def activate_section
    authorize! :activate_section, User
    update_users_in_section(params[:section], true)
    flash[:notice] = "Section '#{params[:section]}' has been activated"
    redirect_to :action => :section_list
  end

  # PATCH /admin/deactivate_section/:section
  def deactivate_section
    authorize! :deactivate_section, User
    update_users_in_section(params[:section], false)
    flash[:notice] = "Section '#{params[:section]}' has been deactivated"
    redirect_to :action => :section_list
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

  def update_users_in_section(section, status)
    User.in_section(section).update_all(:active => status)
  end
end
