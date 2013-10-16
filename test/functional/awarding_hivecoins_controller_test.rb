require 'test_helper'

class AwardingHivecoinsControllerTest < ActionController::TestCase
  setup do
    @awarding_hivecoin = awarding_hivecoins(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:awarding_hivecoins)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create awarding_hivecoin" do
    assert_difference('AwardingHivecoin.count') do
      post :create, awarding_hivecoin: { hivecoin: @awarding_hivecoin.hivecoin, user_id: @awarding_hivecoin.user_id, video_id: @awarding_hivecoin.video_id }
    end

    assert_redirected_to awarding_hivecoin_path(assigns(:awarding_hivecoin))
  end

  test "should show awarding_hivecoin" do
    get :show, id: @awarding_hivecoin
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @awarding_hivecoin
    assert_response :success
  end

  test "should update awarding_hivecoin" do
    put :update, id: @awarding_hivecoin, awarding_hivecoin: { hivecoin: @awarding_hivecoin.hivecoin, user_id: @awarding_hivecoin.user_id, video_id: @awarding_hivecoin.video_id }
    assert_redirected_to awarding_hivecoin_path(assigns(:awarding_hivecoin))
  end

  test "should destroy awarding_hivecoin" do
    assert_difference('AwardingHivecoin.count', -1) do
      delete :destroy, id: @awarding_hivecoin
    end

    assert_redirected_to awarding_hivecoins_path
  end
end
