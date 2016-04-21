class HomesController < ApplicationController
  def index

    if isAdmin
      @full_time_employees = FullTimeEmployee.where("verified = ?", 0)
    else
      redirect_to :controller => 'full_time_employees', :action => 'index'
    end
  end
end
