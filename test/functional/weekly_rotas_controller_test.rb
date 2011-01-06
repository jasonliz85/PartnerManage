require 'test_helper'

class WeeklyRotasControllerTest < ActionController::TestCase
  setup do
    @weekly_rota = weekly_rotas(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:weekly_rotas)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create weekly_rota" do
    assert_difference('WeeklyRota.count') do
      post :create, :weekly_rota => @weekly_rota.attributes
    end

    assert_redirected_to weekly_rota_path(assigns(:weekly_rota))
  end

  test "should show weekly_rota" do
    get :show, :id => @weekly_rota.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @weekly_rota.to_param
    assert_response :success
  end

  test "should update weekly_rota" do
    put :update, :id => @weekly_rota.to_param, :weekly_rota => @weekly_rota.attributes
    assert_redirected_to weekly_rota_path(assigns(:weekly_rota))
  end

  test "should destroy weekly_rota" do
    assert_difference('WeeklyRota.count', -1) do
      delete :destroy, :id => @weekly_rota.to_param
    end

    assert_redirected_to weekly_rotas_path
  end
end
