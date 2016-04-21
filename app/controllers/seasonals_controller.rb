class SeasonalsController < ApplicationController
  before_action :set_seasonal, only: [:show, :edit, :update, :destroy]

  # GET /seasonals
  # GET /seasonals.json
  def index
    if isAdmin
      @seasonals = Seasonal.all
    else
      @seasonals = Seasonal.where('seasonYear >= ? OR seasonYear is null', DateTime.now.year)
    end
  end

  # GET /seasonals/1
  # GET /seasonals/1.json
  def show
  end

  # GET /seasonals/new
  def new
    @seasonal = Seasonal.new
    @employee = Employee.new
  end

  # GET /seasonals/1/edit
  def edit
    @seasonal = Seasonal.find(params[:id])
    @employee = Employee.find(@seasonal.employee)
  end

  # POST /seasonals
  # POST /seasonals.json
  def create
    @employee = Employee.new(employee_params)
    @employee.editor_id = current_user.id
    @seasonal = Seasonal.new(seasonal_params)
    if isAdmin
      @seasonal.verified = 1
    end
    respond_to do |format|
        @seasonal.valid?
        if @employee.valid? && @seasonal.valid?
            if @employee.save
                @seasonal.employee = Employee.find(@employee.id)
              format.json { render :show, status: :created, location: @employee }
                if @seasonal.save
                  @logs = Log.new
                  @logs.employeeInfo = @employee.to_json
                  @logs.additionalInfo = @seasonal.to_json
                  @logs.CRUD = "Create"
                  @logs.table = "Seasonal Employee"
                  @logs.who = current_user.name
                  @logs.save
                  format.html { redirect_to @seasonal, notice: 'Full time employee was successfully created.' }
                  format.json { render :show, status: :created, location: @seasonal }
                end
            end
        else
            format.html { render :new }
            format.json { render json: @employee.errors, status: :unprocessable_entity }

            #format.html { render :new }
            format.json { render json: @seasonal.errors, status: :unprocessable_entity }
        end
    end

  end

  # PATCH/PUT /seasonals/1
  # PATCH/PUT /seasonals/1.json
  def update
    if isAdmin
      @seasonal = Seasonal.find(params[:id])
      @employee = @seasonal.employee

      @seasonal.assign_attributes(seasonal_params)
      @employee.assign_attributes(employee_params)
      respond_to do |format|
        @seasonal.valid?
        if @employee.valid? && @seasonal.valid?
          @employee.editor_id = current_user.id
          if @seasonal.seasonals_id != nil
            @realFulltime = Seasonal.find(@seasonal.seasonals_id)
            @realEmployee = Employee.find(@realFulltime.employee_id)

            @realFulltime.dateOfHire = @seasonal.dateOfHire
            @realFulltime.dateofTermination = @seasonal.dateofTermination
            @realFulltime.hourlyRate = @seasonal.hourlyRate
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

            @seasonal.destroy
            @employee.destroy
          else
            @logs = Log.new
            @logs.employeeInfo = @employee.to_json
            @logs.additionalInfo = @seasonal.to_json
            @logs.CRUD = "Update"
            @logs.table = "Seasonal Employee"
            @logs.who = current_user.name
            @logs.save
            @employee.save
            @seasonal.save
          end
          format.html { redirect_to @seasonal, notice: 'Full time employee was successfully updated.' }
          format.json { render :show, status: :ok, location: @seasonal }
        else
            format.html { render :new }
            format.json { render json: @employee.errors, status: :unprocessable_entity }

            #format.html { render :new }
            format.json { render json: @seasonal.errors, status: :unprocessable_entity }
        end
      end
    else
      @employee = Employee.new(employee_params)

      @employee.editor_id = current_user.id
      @seasonal = Seasonal.new(seasonal_params)
      @oldFullTime = Seasonal.find(params[:id])
      @oldFullTimeId = @oldFullTime.seasonals_id
      if @oldFullTimeId == nil
        @oldFullTimeId = @oldFullTime.id
      end
      @seasonal.seasonals_id = @oldFullTimeId
      @seasonal.hourlyRate = Seasonal.find(params[:id]).hourlyRate

      respond_to do |format|
          @seasonal.valid?
          if @employee.valid? && @seasonal.valid?
              if @employee.save
                  @seasonal.employee = Employee.find(@employee.id)
                format.json { render :show, status: :created, location: @employee }
                @logs = Log.new
                @logs.employeeInfo = @employee.to_json
                @logs.additionalInfo = @seasonal.to_json
                @logs.CRUD = "Update"
                @logs.table = "Seasonal Employee"
                @logs.who = current_user.name
                @logs.save
                  if @seasonal.save
                    format.html { redirect_to @seasonal, notice: 'Full time employee was successfully created.' }
                    format.json { render :show, status: :created, location: @seasonal }
                  end
              end
          else
              format.html { render :new }
              format.json { render json: @employee.errors, status: :unprocessable_entity }

              #format.html { render :new }
              format.json { render json: @seasonal.errors, status: :unprocessable_entity }
          end
      end
    end
  end

  # DELETE /seasonals/1
  # DELETE /seasonals/1.json
  def destroy
    @seasonal.destroy
    respond_to do |format|
      format.html { redirect_to seasonals_url, notice: 'Seasonal was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_seasonal
      @seasonal = Seasonal.find(params[:id])
    end
    def employee_params
      params.require(:employee).permit(:lastName, :firstName, :sin, :dateOfBirth, :reasonForLeaving, :company_id)
    end
    # Never trust parameters from the scary internet, only allow the white list through.
    def seasonal_params
      params.require(:seasonal).permit(:season, :seasonYear, :piecePay, :employee_id, :verified, :seasonals_id)
    end
end
