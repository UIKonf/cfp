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
    @user.proposals.create!(title: 't' * 5, description: 'b' * 250, state: 'published')
    get new_proposal_url
    assert_redirected_to proposals_url
  end

  test 'should be able to create a proposal if others are not active' do
    log_in_as(@user)
    @user.proposals.create!(title: 't' * 5, description: 'b' * 250, state: 'draft')
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
    @user.proposals.create!(title: 't' * 5, description: 'b' * 250, state: 'published')
    proposal = @user.proposals.create!(title: 't' * 5, description: 'b' * 250)
    post publish_proposal_path(proposal)

    assert_redirected_to proposals_path
    assert_not proposal.published?
  end

  test 'should delete' do
    log_in_as(@user)
    assert_difference 'Proposal.count', -1 do
      delete proposal_path(@proposal)
    end
    assert_redirected_to proposals_path
  end

  test 'only proposal author can destroy proposal' do
    log_in_as(@user)
    proposal = users(:two).proposals.create!(title: 't' * 5, description: 'b' * 250, state: 'published')
    assert_difference 'Proposal.count', 0 do
      delete proposal_path(proposal)
      assert proposal.published?
    end
    assert_redirected_to proposals_path
  end

  test 'only proposal author can edit proposal' do
    log_in_as(@user)
    get edit_proposal_path(proposals(:two))
    assert_redirected_to proposals_path
  end

  test 'only proposal author can patch proposal' do
    log_in_as(@user)
    patch proposal_path(proposals(:two)), params: {proposal: {title: 't' * 5, description: 'd' * 200}}
    assert_redirected_to proposals_path
  end

  test 'only proposal author can put proposal' do
    log_in_as(@user)
    put proposal_path(proposals(:two)), params: {proposal: {title: 't' * 5, description: 'd' * 200}}
    assert_redirected_to proposals_path
  end

  test 'only proposal author can publish' do
    log_in_as(@user)
    post publish_proposal_path(proposals(:two))
    assert_redirected_to proposals_path
  end

  test 'only proposal author can withdraw' do
    log_in_as(@user)
    post withdraw_proposal_path(proposals(:two))
    assert_redirected_to proposals_path
  end

  test 'non published proposal are visible to their user' do
    log_in_as(@user)
    proposal = proposals(:draft)
    get proposal_path(proposal)
    assert_response :success
  end

  test 'non published proposal should raise a RecordNotFound error if requested by non-author' do
    log_in_as(users(:two))
    proposal = proposals(:draft)
    assert_raises ActiveRecord::RecordNotFound do
      get proposal_path(proposal)
    end
  end

  test 'withdrawn proposal are visible to other users' do
    log_in_as(users(:two))
    proposal = proposals(:withdrawn)
    get proposal_path(proposal)
    assert_response :success
  end

  test 'deleted proposals are not visible to the creator' do
    proposal = proposals(:deleted)
    log_in_as(proposal.user)
    assert_raises ActiveRecord::RecordNotFound do
      get proposal_path(proposal)
    end
  end

  test 'deleted proposals are not visible to other users' do
    log_in_as(users(:two))
    proposal = proposals(:deleted)
    assert_raises ActiveRecord::RecordNotFound do
      get proposal_path(proposal)
    end
  end

  test 'published scope' do
    log_in_as(@user)
    assert_difference 'Proposal.published.count', 1 do
      @user.proposals.create!(title: 't' * 5, description: 'b' * 250, state: 'published')
      @user.proposals.create!(title: 't' * 5, description: 'b' * 250, state: 'preselected')
      @user.proposals.create!(title: 't' * 5, description: 'b' * 250, state: 'draft')
    end
  end

  test 'published and preselected scope' do
    log_in_as(@user)
    assert_difference 'Proposal.published_or_preselected.count', 2 do
      @user.proposals.create!(title: 't' * 5, description: 'b' * 250, state: 'published')
      @user.proposals.create!(title: 't' * 5, description: 'b' * 250, state: 'preselected')
      @user.proposals.create!(title: 't' * 5, description: 'b' * 250, state: 'draft')
    end
  end

  test 'preselected scope' do
    log_in_as(@user)
    assert_difference 'Proposal.preselected.count', 1 do
      @user.proposals.create!(title: 't' * 5, description: 'b' * 250, state: 'published')
      @user.proposals.create!(title: 't' * 5, description: 'b' * 250, state: 'preselected')
      @user.proposals.create!(title: 't' * 5, description: 'b' * 250, state: 'draft')
    end
  end

  test 'without_comments_from returns proposals the user commented on' do
    assert Proposal.all.count > Proposal.without_comments_from(users(:one)).count
  end

  test 'without_comments_from returns all proposals if the user has not commented' do
    assert_equal Proposal.all.count, Proposal.without_comments_from(users(:no_comment)).count
  end
end
