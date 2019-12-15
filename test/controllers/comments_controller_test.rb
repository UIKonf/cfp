require 'test_helper'

class CommentsControllerTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:one)
    @proposal = proposals(:one)
  end

  test 'only accessible when logged in' do
    post proposal_comments_path(@proposal)
    assert_authenticated_only
  end

  test 'should create' do
    log_in_as(@user)
    assert_difference 'Comment.count', 1 do
      post proposal_comments_path(@proposal), params: {comment: {body: 'b' * 200}}
    end
    assert_redirected_to @proposal
  end
end
