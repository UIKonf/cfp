# frozen_string_literal: true

require 'test_helper'

class SelectionTest < ActiveSupport::TestCase
  def setup
    @user = users(:one)
    @proposal = proposals(:preselected)
    @selection = Selection.new(user_id: @user.id, proposal_id: @proposal.id)
  end

  test 'should be valid' do
    assert @selection.valid?
  end

  test 'a user can have a maximum of 8 selections' do
    user = users(:sabine)
    8.times do
      proposal = user.proposals.create!(title: 't' * 5, description: 'd' * 200)
      user.selections.create!(proposal: proposal)
    end

    selection = user.selections.build(proposal: proposals(:one))
    assert_not selection.valid?
  end
end
