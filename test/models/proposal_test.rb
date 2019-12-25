require 'test_helper'

class ProposalTest < ActiveSupport::TestCase
  def setup
    @user = users(:sabine)
    @proposal = @user.proposals.build(title: 'title', description: 'd' * 201)
  end

  test 'should be valid' do
    assert @proposal.valid?
  end

  test 'user_id should be present' do
    @proposal.user_id = nil
    assert_not @proposal.valid?
  end

  test 'title should be present' do
    @proposal.title = nil
    assert_not @proposal.valid?
  end

  test 'title should be longer than 5 characters' do
    @proposal.title = 'sup'
    assert_not @proposal.valid?
  end

  test 'description should be present' do
    @proposal.description = nil
    assert_not @proposal.valid?
  end

  test 'description should be longer than 200 characters' do
    @proposal.description = 'a' * 199
    assert_not @proposal.valid?
  end

  test 'state should be present' do
    @proposal.state = nil
    assert_not @proposal.valid?
  end

  test 'state defaults to draft' do
    assert @proposal.draft?
  end

  test 'can_publish? is true when state is draft' do
    @proposal.update(state: 'draft')
    assert @proposal.can_publish?
  end

  test 'can_publish? is true when state is withdrawn' do
    @proposal.update(state: 'withdrawn')
    assert @proposal.can_publish?
  end

  test 'can_withdraw? is true when state is published' do
    @proposal.update(state: 'published')
    assert @proposal.can_withdraw?
  end

  test 'can_withdraw? is true when state is preselected' do
    @proposal.update(state: 'preselected')
    assert @proposal.can_withdraw?
  end
end
