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

  test 'new proposals are not live' do
    assert_not @proposal.live
  end

  test 'proposals can be published' do
    @proposal.publish!
    assert @proposal.live
  end

  test 'proposals can be withdrawn' do
    @proposal.withdraw!
    assert_not @proposal.live
  end
end
