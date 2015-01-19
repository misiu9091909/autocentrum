require 'test_helper'

class BeCombinesControllerTest < ActionController::TestCase
  setup do
    @be_combine = be_combines(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:be_combines)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create be_combine" do
    assert_difference('BeCombine.count') do
      post :create, be_combine: { end_year: @be_combine.end_year, link: @be_combine.link, name: @be_combine.name, start_year: @be_combine.start_year, techspec: @be_combine.techspec }
    end

    assert_redirected_to be_combine_path(assigns(:be_combine))
  end

  test "should show be_combine" do
    get :show, id: @be_combine
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @be_combine
    assert_response :success
  end

  test "should update be_combine" do
    patch :update, id: @be_combine, be_combine: { end_year: @be_combine.end_year, link: @be_combine.link, name: @be_combine.name, start_year: @be_combine.start_year, techspec: @be_combine.techspec }
    assert_redirected_to be_combine_path(assigns(:be_combine))
  end

  test "should destroy be_combine" do
    assert_difference('BeCombine.count', -1) do
      delete :destroy, id: @be_combine
    end

    assert_redirected_to be_combines_path
  end
end
