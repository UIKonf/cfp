# frozen_string_literal: true

require 'test_helper'

class ProposalsControllerTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:one)
    @proposal = proposals(:one)
  end

  test 'only accessible when logged in' do
    get proposals_url
    assert_authenticated_only
  end

  test 'should get index' do
    log_in_as(@user)
    get proposals_url
    assert_response :success
  end

  test 'should get new proposal' do
    log_in_as(@user)
    get new_proposal_url
    assert_response :success
  end

  test 'should not be able to create a proposal if another is active' do
    log_in_as(@user)
    @user.proposals.create!(title: 't' * 5, description: 'b' * 250, live: true)
    get new_proposal_url
    assert_redirected_to proposals_url
  end

  test 'should be able to create a proposal if others are not active' do
    log_in_as(@user)
    @user.proposals.create!(title: 't' * 5, description: 'b' * 250, live: false)
    get new_proposal_url
    assert_response :success
  end

  test 'should post publish' do
    log_in_as(@user)
    post publish_proposal_path(@proposal)
    assert_redirected_to @proposal
  end

  test 'should post withdraw' do
    log_in_as(@user)
    post withdraw_proposal_path(@proposal)
    assert_redirected_to @proposal
  end

  test 'only one proposal can be published' do
    log_in_as(@user)
    @user.proposals.create!(title: 't' * 5, description: 'b' * 250, live: true)
    proposal = @user.proposals.create!(title: 't' * 5, description: 'b' * 250, live: false)
    post publish_proposal_path(proposal)

    assert_redirected_to proposals_path
    assert_not proposal.live
  end
end
