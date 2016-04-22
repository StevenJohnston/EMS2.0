#Group: silicon Central
#Assignment: EMS PSS
#Date: 4/21/2016
class SeniorityReportController < ApplicationController
  def index
    if isAdmin
      @companies = Company.all
    elsif isGeneral
      @companies = Company.all
    else
      redirect_to :controller => 'sessions', :action => 'new'
    end
  end
  def show
    @company = Company.find(params[:id])
    @employees = Employee.where('company_id = ?', params[:id])
    @employees.each do |object|
      object.firstName = object.lastName + ", " + object.firstName
      @child = FullTimeEmployee.where('employee_id = ?', object.id)
      if @child.size == 1
        object.lastName =((DateTime.now - @child.at(0).dateOfHire).to_f/365).round
        object.reasonForLeaving = "Full Time"
        object.dateOfBirth = @child.at(0).dateOfHire
      else
        @child = PartTimeEmployee.where('employee_id = ?', object.id)
        if @child.size == 1
          object.lastName =((DateTime.now - @child.at(0).dateOfHire).to_f/365).round
          object.reasonForLeaving = "Part Time"
          object.dateOfBirth = @child.at(0).dateOfHire
        else
          @child = Seasonal.where('employee_id = ?', object.id)
          if @child.size == 1
            object.lastName =((DateTime.now - DateTime.new(@child.at(0).seasonYear)).to_f/365).round
            object.reasonForLeaving = "Seasonal"
            @seas = @child.at(0).season
            @month
            if @seas == "Spring"
              @month = 3
            elsif @seas == "Summer"
              @month = 6
            elsif @seas == "Fall"
              @month = 9
            elsif @seas == "Winter"
              @month = 12
            end
            object.dateOfBirth = DateTime.new(@child.at(0).seasonYear,@month,01)
          else
            @child = ContractEmployee.where('employee_id = ?', object.id)
            if @child.size == 1
              object.lastName =((DateTime.now - @child.at(0).contractStartDate).to_f/365).round
              object.reasonForLeaving = "Contract"
              object.dateOfBirth = @child.at(0).contractStartDate
            end
          end
        end
      end
    end
  end
end
