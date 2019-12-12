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

  test 'should delete' do
    log_in_as(@user)
    comment = @user.comments.create(body: 'b' * 200, proposal: @proposal)
    delete proposal_comment_path(@proposal, comment)
    assert_redirected_to @proposal
  end

  test 'should only delete comments the logged in user posted' do
    log_in_as(users(:two))
    comment = @user.comments.create(body: 'b' * 200, proposal: @proposal)
    assert_difference 'Comment.count', 0 do
      delete proposal_comment_path(@proposal, comment)
    end
    assert_redirected_to @proposal
  end
end
