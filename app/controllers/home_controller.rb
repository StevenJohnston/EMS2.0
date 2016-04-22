#Group: silicon Central
#Assignment: EMS PSS
#Date: 4/21/2016
class HomeController < ApplicationController
  def index

    if isAdmin
      @full_time_employees = FullTimeEmployeesController::FullTimeEmployees.where("verified = ?", 0)
    else
      redirect_to :controller => 'full_time_employees', :action => 'index'
    end
  end
end
