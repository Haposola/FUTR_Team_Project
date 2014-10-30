require 'test_helper'

class OutservicesControllerTest < ActionController::TestCase
  setup do
    @outservice = outservices(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:outservices)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create outservice" do
    assert_difference('Outservice.count') do
      post :create, outservice: {  }
    end

    assert_redirected_to outservice_path(assigns(:outservice))
  end

  test "should show outservice" do
    get :show, id: @outservice
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @outservice
    assert_response :success
  end

  test "should update outservice" do
    put :update, id: @outservice, outservice: {  }
    assert_redirected_to outservice_path(assigns(:outservice))
  end

  test "should destroy outservice" do
    assert_difference('Outservice.count', -1) do
      delete :destroy, id: @outservice
    end

    assert_redirected_to outservices_path
  end
end
