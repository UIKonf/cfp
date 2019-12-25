# frozen_string_literal: true

require 'test_helper'

class ProposalsHelperTest < ActionView::TestCase
  def setup
    @proposal = proposals(:one)
  end

  test 'show_comments? returns false when proposal is draft' do
    @proposal.state = 'draft'
    assert_not show_comments?(@proposal)
  end

  test 'show_comments? returns false when proposal is withdrawn' do
    @proposal.state = 'withdrawn'
    assert_not show_comments?(@proposal)
  end

  test 'show_comments? returns true when proposal is published' do
    @proposal.state = 'published'
    assert show_comments?(@proposal)
  end

  test 'show_comments? returns true when proposal is preselected' do
    @proposal.state = 'preselected'
    assert show_comments?(@proposal)
  end

  test 'show_comment_form? returns true when app is in cfp mode' do
    Cfp.mode = :cfp
    assert show_comment_form?
  end

  test 'show_comment_form? returns true when app is in review mode' do
    Cfp.mode = :review
    assert show_comment_form?
  end

  test 'show_comment_form? returns false when app is in hold mode' do
    Cfp.mode = :hold
    assert_not show_comment_form?
  end

  test 'show_comment_form? returns false when app is in selection mode' do
    Cfp.mode = :selection
    assert_not show_comment_form?
  end

  test 'show_comment_form? returns false when app is in archive mode' do
    Cfp.mode = :archive
    assert_not show_comment_form?
  end

  test 'can_edit? returns true when app is in cfp mode' do
    Cfp.mode = :cfp
    assert can_edit?
  end

  test 'can_edit? returns true when app is in review mode' do
    Cfp.mode = :review
    assert can_edit?
  end
end
