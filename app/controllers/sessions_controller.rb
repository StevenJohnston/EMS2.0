#Group: silicon Central
#Assignment: EMS PSS
#Date: 4/21/2016
class SessionsController < ApplicationController
  def new
  end
  def create
    user = User.find_by_name(params[:name])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to :controller => 'homes', :action => 'index'
    else
      render :new
    end
  end
  def destroy
    session[:user_id] = nil
    redirect_to root_url, notice: 'Logged out!'
  end
end
