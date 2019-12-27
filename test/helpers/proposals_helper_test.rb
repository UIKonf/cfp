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

  test 'default scope filters out deleted proposals' do
    assert_difference 'Proposal.all.count', 0 do
      Proposal.create!(user: users(:one), title: 't'*20, description: 'd'*300, state: 'deleted')
    end
  end
end
