#Group: silicon Central
#Assignment: EMS PSS
#Date: 4/21/2016
class ContractEmployeesController < ApplicationController
  before_action :set_contract_employee, only: [:show, :edit, :update, :destroy]

  # GET /contract_employees
  # GET /contract_employees.json
  def index
    if isAdmin
      @contract_employees = ContractEmployee.all
    else
      redirect_to :controller => 'full_time_employees', :action => 'index'
    end
  end

  # GET /contract_employees/1
  # GET /contract_employees/1.json
  def show
    if isGeneral
      redirect_to :controller => 'full_time_employees', :action => 'index'
    end
  end

  # GET /contract_employees/new
  def new
    if isGeneral
      redirect_to :controller => 'full_time_employees', :action => 'index'
    else
      @contract_employee = ContractEmployee.new
      @employee = Employee.new
    end
  end

  # GET /contract_employees/1/edit
  def edit
    if isGeneral
      redirect_to :controller => 'full_time_employees', :action => 'index'
    else
      @contract_employee = ContractEmployee.find(params[:id])
      @employee = Employee.find(@contract_employee.employee)
    end
  end

  # POST /contract_employees
  # POST /contract_employees.json
  def create
    if isGeneral
      redirect_to :controller => 'full_time_employees', :action => 'index'
    else
      @employee = Employee.new(employee_params)
      @employee.editor_id = current_user.id
      @contract_employee = ContractEmployee.new(contract_employee_params)
      if isAdmin
        @contract_employee.verified = 1
      end
      respond_to do |format|
          @contract_employee.valid?
          if @employee.valid? && @contract_employee.valid?
              if @employee.save
                  @contract_employee.employee = Employee.find(@employee.id)
                format.json { render :show, status: :created, location: @employee }
                  if @contract_employee.save
                    @logs = Log.new
                    @logs.employeeInfo = @employee.to_json
                    @logs.additionalInfo = @contract_employee.to_json
                    @logs.CRUD = "Create"
                    @logs.table = "ContractEmployee Employee"
                    @logs.who = current_user.name
                    @logs.save
                    format.html { redirect_to @contract_employee, notice: 'Full time employee was successfully created.' }
                    format.json { render :show, status: :created, location: @contract_employee }
                  end
              end
          else
              format.html { render :new }
              format.json { render json: @employee.errors, status: :unprocessable_entity }

              #format.html { render :new }
              format.json { render json: @contract_employee.errors, status: :unprocessable_entity }
          end
      end
    end

  end

  # PATCH/PUT /contract_employees/1
  # PATCH/PUT /contract_employees/1.json
  def update
    if isAdmin
      @contract_employee = ContractEmployee.find(params[:id])
      @employee = @contract_employee.employee

      @contract_employee.assign_attributes(contract_employee_params)
      @employee.assign_attributes(employee_params)
      respond_to do |format|
        @contract_employee.valid?
        if @employee.valid? && @contract_employee.valid?
          @employee.editor_id = current_user.id
          if @contract_employee.contract_employees_id != nil
            @realFulltime = ContractEmployee.find(@contract_employee.contract_employees_id)
            @realEmployee = Employee.find(@realFulltime.employee_id)

            @realFulltime.dateOfHire = @contract_employee.dateOfHire
            @realFulltime.dateofTermination = @contract_employee.dateofTermination
            @realFulltime.hourlyRate = @contract_employee.hourlyRate
            @realFulltime.verified = 1

            @realEmployee.lastName = @employee.lastName
            @realEmployee.firstName = @employee.firstName
            @realEmployee.sin = @employee.sin
            @realEmployee.dateOfBirth = @employee.dateOfBirth
            @realEmployee.reasonForLeaving = @employee.reasonForLeaving
            @realEmployee.company_id = @employee.company_id
            @realEmployee.editor_id = current_user.id

            @realEmployee.save
            @realFulltime.save

            @contract_employee.destroy
            @employee.destroy
          else
            @logs = Log.new
            @logs.employeeInfo = @employee.to_json
            @logs.additionalInfo = @contract_employee.to_json
            @logs.CRUD = "Update"
            @logs.table = "ContractEmployee Employee"
            @logs.who = current_user.name
            @logs.save
            @employee.save
            @contract_employee.save
          end
          format.html { redirect_to @contract_employee, notice: 'Full time employee was successfully updated.' }
          format.json { render :show, status: :ok, location: @contract_employee }
        else
            format.html { render :new }
            format.json { render json: @employee.errors, status: :unprocessable_entity }

            #format.html { render :new }
            format.json { render json: @contract_employee.errors, status: :unprocessable_entity }
        end
      end
    else
      redirect_to :controller => 'full_time_employees', :action => 'index'
    end
  end

  # DELETE /contract_employees/1
  # DELETE /contract_employees/1.json
  def destroy
    if isGeneral
      redirect_to :controller => 'full_time_employees', :action => 'index'
    else
      @contract_employee.destroy
      respond_to do |format|
        format.html { redirect_to contract_employees_url, notice: 'Contract employee was successfully destroyed.' }
        format.json { head :no_content }
      end
    end
  end

  private
    def employee_params
      params.require(:employee).permit(:lastName, :firstName, :sin, :dateOfBirth, :reasonForLeaving, :company_id)
    end
    # Use callbacks to share common setup or constraints between actions.
    def set_contract_employee
      @contract_employee = ContractEmployee.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def contract_employee_params
      params.require(:contract_employee).permit(:contractStartDate, :contractStopDate, :fixedContractAmount, :employee_id, :verified)
    end
end
