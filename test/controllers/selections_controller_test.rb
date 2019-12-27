require 'test_helper'

class SelectionsControllerTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:one)
    @proposal = proposals(:one)
    @selection = selections(:one)

    @mode = Cfp.mode.mode
    Cfp.mode = :selection
  end

  def teardown
    Cfp.mode = @mode
  end

  test 'only accessible when logged in' do
    get user_selections_url(@user)
    assert_authenticated_only
  end

  test 'index not accessible in cfp mode' do
    with_mode :cfp do
      log_in_as(@user)
      get user_selections_url(@user)
      assert_redirected_to root_url
    end
  end

  test 'should get index' do
    log_in_as(@user)
    get user_selections_url(@user)
    assert_response :success
  end

  test 'should create' do
    log_in_as(@user)
    assert_difference 'Selection.count', 1 do
      post user_selections_url(@user), params: {proposal_id: proposals(:preselected).id}
    end
    assert_response :found
  end

  test 'cannot select proposal that is not preselected' do
    log_in_as(@user)
    assert_difference 'Selection.count', 0 do
      post user_selections_url(@user), params: {proposal_id: proposals(:draft).id}
    end
    assert_response :redirect
  end

  test 'should delete' do
    log_in_as(@user)
    assert_difference 'Selection.count', -1 do
      delete user_selection_url(@user, @selection)
    end
  end
end
