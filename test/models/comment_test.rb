require 'test_helper'

class CommentTest < ActiveSupport::TestCase
  def setup
    @user = users(:sabine)
    @proposal = proposals(:one)
    @comment = @proposal.comments.build(body: 'b' * 51, user_id: @user.id)
  end

  test 'should be valid' do
    assert @comment.valid?
  end

  test 'user_id should be present' do
    @comment.user_id = nil
    assert_not @comment.valid?
  end

  test 'proposal_id should be present' do
    @comment.proposal_id = nil
    assert_not @comment.valid?
  end

  test 'body should be longer than 50 characters' do
    @comment.body = 'b' * 49
    assert_not @comment.valid?
  end
end
