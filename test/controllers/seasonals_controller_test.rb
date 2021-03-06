require 'test_helper'

class SeasonalsControllerTest < ActionController::TestCase
  setup do
    @seasonal = seasonals(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:seasonals)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create seasonal" do
    assert_difference('Seasonal.count') do
      post :create, seasonal: { employee_id: @seasonal.employee_id, piecePay: @seasonal.piecePay, season: @seasonal.season, seasonYear: @seasonal.seasonYear, verified: @seasonal.verified }
    end

    assert_redirected_to seasonal_path(assigns(:seasonal))
  end

  test "should show seasonal" do
    get :show, id: @seasonal
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @seasonal
    assert_response :success
  end

  test "should update seasonal" do
    patch :update, id: @seasonal, seasonal: { employee_id: @seasonal.employee_id, piecePay: @seasonal.piecePay, season: @seasonal.season, seasonYear: @seasonal.seasonYear, verified: @seasonal.verified }
    assert_redirected_to seasonal_path(assigns(:seasonal))
  end

  test "should destroy seasonal" do
    assert_difference('Seasonal.count', -1) do
      delete :destroy, id: @seasonal
    end

    assert_redirected_to seasonals_path
  end
end
