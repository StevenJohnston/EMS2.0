class PartTimeEmployeesController < ApplicationController
  before_action :set_part_time_employee, only: [:show, :edit, :update, :destroy]

  # GET /part_time_employees
  # GET /part_time_employees.json
  def index
    if isAdmin
      @part_time_employees = PartTimeEmployee.all
    else
      @part_time_employees = PartTimeEmployee.where('dateofTermination >= ? OR dateofTermination is null', DateTime.now)
    end
  end

  # GET /part_time_employees/1
  # GET /part_time_employees/1.json
  def show
  end

  # GET /part_time_employees/new
  def new
    @part_time_employee = PartTimeEmployee.new
    @employee = Employee.new
  end

  # GET /part_time_employees/1/edit
  def edit
    @part_time_employee = PartTimeEmployee.find(params[:id])
    @employee = Employee.find(@part_time_employee.employee)
  end

  # POST /part_time_employees
  # POST /part_time_employees.json
  def create
    @employee = Employee.new(employee_params)
    @employee.editor_id = current_user.id
    @part_time_employee = PartTimeEmployee.new(part_time_employee_params)
    if isAdmin
      @part_time_employee.verified = 1
    end
    respond_to do |format|
        @part_time_employee.valid?
        if @employee.valid? && @part_time_employee.valid?
            if @employee.save
                @part_time_employee.employee = Employee.find(@employee.id)
              format.json { render :show, status: :created, location: @employee }
                if @part_time_employee.save
                  @logs = Log.new
                  @logs.employeeInfo = @employee.to_json
                  @logs.additionalInfo = @part_time_employee.to_json
                  @logs.CRUD = "Create"
                  @logs.table = "Full Time Employee"
                  @logs.who = current_user.name
                  @logs.save
                  format.html { redirect_to @part_time_employee, notice: 'Full time employee was successfully created.' }
                  format.json { render :show, status: :created, location: @part_time_employee }
                end
            end
        else
            format.html { render :new }
            format.json { render json: @employee.errors, status: :unprocessable_entity }

            #format.html { render :new }
            format.json { render json: @part_time_employee.errors, status: :unprocessable_entity }
        end
    end


  end

  # PATCH/PUT /part_time_employees/1
  # PATCH/PUT /part_time_employees/1.json
  def update
    if isAdmin
      @part_time_employee = PartTimeEmployee.find(params[:id])
      @employee = @part_time_employee.employee

      @part_time_employee.assign_attributes(part_time_employee_params)
      @employee.assign_attributes(employee_params)
      respond_to do |format|
        @part_time_employee.valid?
        if @employee.valid? && @part_time_employee.valid?
          @employee.editor_id = current_user.id
          if @part_time_employee.part_time_employees_id != nil
            @realFulltime = PartTimeEmployee.find(@part_time_employee.part_time_employees_id)
            @realEmployee = Employee.find(@realFulltime.employee_id)

            @realFulltime.dateOfHire = @part_time_employee.dateOfHire
            @realFulltime.dateofTermination = @part_time_employee.dateofTermination
            @realFulltime.hourlyRate = @part_time_employee.hourlyRate
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

            @part_time_employee.destroy
            @employee.destroy
          else
            @logs = Log.new
            @logs.employeeInfo = @employee.to_json
            @logs.additionalInfo = @part_time_employee.to_json
            @logs.CRUD = "Update"
            @logs.table = "Full Time Employee"
            @logs.who = current_user.name
            @logs.save
            @employee.save
            @part_time_employee.save
          end
          format.html { redirect_to @part_time_employee, notice: 'Full time employee was successfully updated.' }
          format.json { render :show, status: :ok, location: @part_time_employee }
        else
            format.html { render :new }
            format.json { render json: @employee.errors, status: :unprocessable_entity }

            #format.html { render :new }
            format.json { render json: @part_time_employee.errors, status: :unprocessable_entity }
        end
      end
    else
      @employee = Employee.new(employee_params)

      @employee.editor_id = current_user.id
      @part_time_employee = PartTimeEmployee.new(part_time_employee_params)
      @oldFullTime = PartTimeEmployee.find(params[:id])
      @oldFullTimeId = @oldFullTime.part_time_employees_id
      if @oldFullTimeId == nil
        @oldFullTimeId = @oldFullTime.id
      end
      @part_time_employee.part_time_employees_id = @oldFullTimeId
      @part_time_employee.hourlyRate = PartTimeEmployee.find(params[:id]).hourlyRate

      respond_to do |format|
          @part_time_employee.valid?
          if @employee.valid? && @part_time_employee.valid?
              if @employee.save
                  @part_time_employee.employee = Employee.find(@employee.id)
                format.json { render :show, status: :created, location: @employee }
                @logs = Log.new
                @logs.employeeInfo = @employee.to_json
                @logs.additionalInfo = @part_time_employee.to_json
                @logs.CRUD = "Update"
                @logs.table = "Full Time Employee"
                @logs.who = current_user.name
                @logs.save
                  if @part_time_employee.save
                    format.html { redirect_to @part_time_employee, notice: 'Full time employee was successfully created.' }
                    format.json { render :show, status: :created, location: @part_time_employee }
                  end
              end
          else
              format.html { render :new }
              format.json { render json: @employee.errors, status: :unprocessable_entity }

              #format.html { render :new }
              format.json { render json: @part_time_employee.errors, status: :unprocessable_entity }
          end
      end
    end
  end

  # DELETE /part_time_employees/1
  # DELETE /part_time_employees/1.json
  def destroy
    @part_time_employee.destroy
    respond_to do |format|
      format.html { redirect_to part_time_employees_url, notice: 'Part time employee was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_part_time_employee
      @part_time_employee = PartTimeEmployee.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def part_time_employee_params
      params.require(:part_time_employee).permit(:dateOfHire, :dateOfTermination, :hourlyRate)
    end
    def employee_params
      params.require(:employee).permit(:lastName, :firstName, :sin, :dateOfBirth, :reasonForLeaving, :company_id)
    end
    def isAdmin()
      return current_user && current_user.userType == "Admin"
    end

    def isGeneral()
      return current_user && current_user.userType == "General"
    end
end
