class FullTimeEmployeesController < ApplicationController
  before_action :set_full_time_employee, only: [:show, :edit, :update, :destroy]

  # GET /full_time_employees
  # GET /full_time_employees.json
  def index
    if isAdmin
      @full_time_employees = FullTimeEmployee.all
    else
      @full_time_employees = FullTimeEmployee.where('dateofTermination >= ? OR dateofTermination is null', DateTime.now)
    end
  end

  # GET /full_time_employees/1
  # GET /full_time_employees/1.json
  def show
    @full_time_employee = FullTimeEmployee.find(params[:id])
  end

  # GET /full_time_employees/new
  def new
    @full_time_employee = FullTimeEmployee.new
    @employee = Employee.new
  end

  # GET /full_time_employees/1/edit
  def edit
      @full_time_employee = FullTimeEmployee.find(params[:id])
      @employee = Employee.find(@full_time_employee.employee)
  end

  # POST /full_time_employees
  # POST /full_time_employees.json
  def create

    @employee = Employee.new(employee_params)
    @employee.editor_id = current_user.id
    @full_time_employee = FullTimeEmployee.new(full_time_employee_params)
    if isAdmin
      @full_time_employee.verified = 1
    end
    respond_to do |format|
        @full_time_employee.valid?
        if @employee.valid? && @full_time_employee.valid?
            if @employee.save
                @full_time_employee.employee = Employee.find(@employee.id)
              format.json { render :show, status: :created, location: @employee }
                if @full_time_employee.save
                  format.html { redirect_to @full_time_employee, notice: 'Full time employee was successfully created.' }
                  format.json { render :show, status: :created, location: @full_time_employee }
                end
            end
        else
            format.html { render :new }
            format.json { render json: @employee.errors, status: :unprocessable_entity }

            #format.html { render :new }
            format.json { render json: @full_time_employee.errors, status: :unprocessable_entity }
        end
    end

  end

  # PATCH/PUT /full_time_employees/1
  # PATCH/PUT /full_time_employees/1.json
  def update
    if isAdmin
      @full_time_employee = FullTimeEmployee.find(params[:id])
      @employee = @full_time_employee.employee

      @full_time_employee.assign_attributes(full_time_employee_params)
      @employee.assign_attributes(employee_params)
      respond_to do |format|
        @full_time_employee.valid?
        if @employee.valid? && @full_time_employee.valid?
          @employee.editor_id = current_user.id
          if @full_time_employee.full_time_employees_id != nil
            @realFulltime = FullTimeEmployee.find(@full_time_employee.full_time_employees_id)
            @realEmployee = Employee.find(@realFulltime.employee_id)

            @realFulltime.dateOfHire = @full_time_employee.dateOfHire
            @realFulltime.dateofTermination = @full_time_employee.dateofTermination
            @realFulltime.salary = @full_time_employee.salary
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

            @full_time_employee.destroy
            @employee.destroy
          else
            @employee.save
            @full_time_employee.save
          end
          format.html { redirect_to @full_time_employee, notice: 'Full time employee was successfully updated.' }
          format.json { render :show, status: :ok, location: @full_time_employee }
        else
            format.html { render :new }
            format.json { render json: @employee.errors, status: :unprocessable_entity }

            #format.html { render :new }
            format.json { render json: @full_time_employee.errors, status: :unprocessable_entity }
        end
      end
    else
      @employee = Employee.new(employee_params)

      @employee.editor_id = current_user.id
      @full_time_employee = FullTimeEmployee.new(full_time_employee_params)
      @oldFullTime = FullTimeEmployee.find(params[:id])
      @oldFullTimeId = @oldFullTime.full_time_employees_id
      if @oldFullTimeId == nil
        @oldFullTimeId = @oldFullTime.id
      end
      @full_time_employee.full_time_employees_id = @oldFullTimeId
      @full_time_employee.salary = FullTimeEmployee.find(params[:id]).salary

      respond_to do |format|
          @full_time_employee.valid?
          if @employee.valid? && @full_time_employee.valid?
              if @employee.save
                  @full_time_employee.employee = Employee.find(@employee.id)
                format.json { render :show, status: :created, location: @employee }
                  if @full_time_employee.save
                    format.html { redirect_to @full_time_employee, notice: 'Full time employee was successfully created.' }
                    format.json { render :show, status: :created, location: @full_time_employee }
                  end
              end
          else
              format.html { render :new }
              format.json { render json: @employee.errors, status: :unprocessable_entity }

              #format.html { render :new }
              format.json { render json: @full_time_employee.errors, status: :unprocessable_entity }
          end
      end
    end
  end

  # DELETE /full_time_employees/1
  # DELETE /full_time_employees/1.json
  def destroy
    @full_time_employee.destroy
    respond_to do |format|
      format.html { redirect_to full_time_employees_url, notice: 'Full time employee was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_full_time_employee
      @full_time_employee = FullTimeEmployee.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def full_time_employee_params
      params.require(:full_time_employee).permit(:dateOfHire, :dateofTermination, :salary, :employee_id)
    end
    # employee data
    def employee_params
      params.require(:employee).permit(:lastName, :firstName, :sin, :dateOfBirth, :reasonForLeaving, :company_id)
    end

    def isAdmin()
      return current_user && current_user.userType == "Admin"
    end

    def isGeneral()
      return current_user && current_user.userType == "General"
    end
    helper_method :isAdmin
end
