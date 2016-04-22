#Group: silicon Central
#Assignment: EMS PSS
#Date: 4/21/2016

class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  private
  def current_user
    User.where(id: session[:user_id]).first
  end

  helper_method :current_user

  def isAdmin
    return current_user && current_user.userType == "Admin"
  end

  def isGeneral
    return current_user && current_user.userType == "General"
  end
  helper_method :isAdmin
  helper_method :isGeneral
end
