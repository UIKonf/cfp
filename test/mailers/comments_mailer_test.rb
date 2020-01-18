require 'test_helper'

class CommentsMailerTest < ActionMailer::TestCase
  test 'new comment' do
    email = CommentsMailer.with(proposal: proposals(:two), comment: comments(:comment_from_one_on_two)).new_comment_email

    assert_emails 1 do
      email.deliver_now
    end

    assert_equal ['questions@uikonf.com'], email.from
    assert_equal ['john@example.com'], email.to
  end

  test 'new comment audit' do
    email = CommentsMailer.with(proposal: proposals(:two), comment: comments(:comment_from_one_on_two)).new_comment_audit_email

    assert_emails 1 do
      email.deliver_now
    end

    assert_equal ['questions@uikonf.com'], email.from
    assert_equal ['sabine@uikonf.com'], email.to
  end
end
