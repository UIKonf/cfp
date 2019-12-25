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
    with_mode :cfp do
      assert show_comment_form?
    end
  end

  test 'show_comment_form? returns true when app is in review mode' do
    with_mode :review do
      assert show_comment_form?
    end
  end

  test 'show_comment_form? returns false when app is in hold mode' do
    with_mode :hold do
      assert_not show_comment_form?
    end
  end

  test 'show_comment_form? returns false when app is in selection mode' do
    with_mode :selection do
      assert_not show_comment_form?
    end
  end

  test 'show_comment_form? returns false when app is in archive mode' do
    with_mode :archive do
      assert_not show_comment_form?
    end
  end

  test 'can_edit? returns true when app is in cfp mode' do
    with_mode :cfp do
      assert can_edit?
    end
  end

  test 'can_edit? returns true when app is in review mode' do
    with_mode :review do
      assert can_edit?
    end
  end

  test 'default scope filters out deleted proposals' do
    assert_difference 'Proposal.all.count', 0 do
      Proposal.create!(user: users(:one), title: 't'*20, description: 'd'*300, state: 'deleted')
    end
  end
end
