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
end
