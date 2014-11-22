require 'test_helper'

class QanswersControllerTest < ActionController::TestCase
  setup do
    @qanswer = qanswers(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:qanswers)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create qanswer" do
    assert_difference('Qanswer.count') do
      post :create, qanswer: { Answer: @qanswer.Answer, Nickname: @qanswer.Nickname }
    end

    assert_redirected_to qanswer_path(assigns(:qanswer))
  end

  test "should show qanswer" do
    get :show, id: @qanswer
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @qanswer
    assert_response :success
  end

  test "should update qanswer" do
    put :update, id: @qanswer, qanswer: { Answer: @qanswer.Answer, Nickname: @qanswer.Nickname }
    assert_redirected_to qanswer_path(assigns(:qanswer))
  end

  test "should destroy qanswer" do
    assert_difference('Qanswer.count', -1) do
      delete :destroy, id: @qanswer
    end

    assert_redirected_to qanswers_path
  end
end
