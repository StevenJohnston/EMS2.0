require 'test_helper'

class ContractEmployeesControllerTest < ActionController::TestCase
  setup do
    @contract_employee = contract_employees(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:contract_employees)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create contract_employee" do
    assert_difference('ContractEmployee.count') do
      post :create, contract_employee: { contractStartDate: @contract_employee.contractStartDate, contractStopDate: @contract_employee.contractStopDate, employee_id: @contract_employee.employee_id, fixedContractAmount: @contract_employee.fixedContractAmount, verified: @contract_employee.verified }
    end

    assert_redirected_to contract_employee_path(assigns(:contract_employee))
  end

  test "should show contract_employee" do
    get :show, id: @contract_employee
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @contract_employee
    assert_response :success
  end

  test "should update contract_employee" do
    patch :update, id: @contract_employee, contract_employee: { contractStartDate: @contract_employee.contractStartDate, contractStopDate: @contract_employee.contractStopDate, employee_id: @contract_employee.employee_id, fixedContractAmount: @contract_employee.fixedContractAmount, verified: @contract_employee.verified }
    assert_redirected_to contract_employee_path(assigns(:contract_employee))
  end

  test "should destroy contract_employee" do
    assert_difference('ContractEmployee.count', -1) do
      delete :destroy, id: @contract_employee
    end

    assert_redirected_to contract_employees_path
  end
end
