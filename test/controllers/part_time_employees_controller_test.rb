require 'test_helper'

class PartTimeEmployeesControllerTest < ActionController::TestCase
  setup do
    @part_time_employee = part_time_employees(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:part_time_employees)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create part_time_employee" do
    assert_difference('PartTimeEmployee.count') do
      post :create, part_time_employee: { dateOfHire: @part_time_employee.dateOfHire, dateOfTermination: @part_time_employee.dateOfTermination, hourlyRate: @part_time_employee.hourlyRate }
    end

    assert_redirected_to part_time_employee_path(assigns(:part_time_employee))
  end

  test "should show part_time_employee" do
    get :show, id: @part_time_employee
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @part_time_employee
    assert_response :success
  end

  test "should update part_time_employee" do
    patch :update, id: @part_time_employee, part_time_employee: { dateOfHire: @part_time_employee.dateOfHire, dateOfTermination: @part_time_employee.dateOfTermination, hourlyRate: @part_time_employee.hourlyRate }
    assert_redirected_to part_time_employee_path(assigns(:part_time_employee))
  end

  test "should destroy part_time_employee" do
    assert_difference('PartTimeEmployee.count', -1) do
      delete :destroy, id: @part_time_employee
    end

    assert_redirected_to part_time_employees_path
  end
end
