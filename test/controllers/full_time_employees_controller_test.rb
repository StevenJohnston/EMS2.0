require 'test_helper'

class FullTimeEmployeesControllerTest < ActionController::TestCase
  setup do
    @full_time_employee = full_time_employees(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:full_time_employees)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create full_time_employee" do
    assert_difference('FullTimeEmployee.count') do
      post :create, full_time_employee: { dateOfHire: @full_time_employee.dateOfHire, dateofTermination: @full_time_employee.dateofTermination, employee_id: @full_time_employee.employee_id, salary: @full_time_employee.salary }
    end

    assert_redirected_to full_time_employee_path(assigns(:full_time_employee))
  end

  test "should show full_time_employee" do
    get :show, id: @full_time_employee
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @full_time_employee
    assert_response :success
  end

  test "should update full_time_employee" do
    patch :update, id: @full_time_employee, full_time_employee: { dateOfHire: @full_time_employee.dateOfHire, dateofTermination: @full_time_employee.dateofTermination, employee_id: @full_time_employee.employee_id, salary: @full_time_employee.salary }
    assert_redirected_to full_time_employee_path(assigns(:full_time_employee))
  end

  test "should destroy full_time_employee" do
    assert_difference('FullTimeEmployee.count', -1) do
      delete :destroy, id: @full_time_employee
    end

    assert_redirected_to full_time_employees_path
  end
end
