require 'test_helper'

class CommentsControllerTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:one)
    @proposal = proposals(:one)
    @comment = comments(:one)
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

  test 'render proposals/show when comment is invalid' do
    log_in_as(@user)
    assert_difference 'Comment.count', 0 do
      post proposal_comments_path(@proposal), params: {comment: {body: 'b'}}
    end
    assert_template 'proposals/show'
  end

  test 'should hide comments when calling destroy' do
    log_in_as(@user)
    assert_difference 'Comment.count', 0 do
      delete proposal_comment_path(@proposal, @comment)
    end
    assert_redirected_to @proposal
  end

  test 'index redirects to proposal' do
    log_in_as(@user)
    get proposal_comments_path(@proposal)
    assert_redirected_to @proposal
  end
end
