# frozen_string_literal: true

require 'test_helper'

class ProposalsControllerTest < ActionDispatch::IntegrationTest
  def setup
    @base_title = 'UIKonf CfP'
  end

  test 'should get index' do
    get proposals_url
    assert_response :success
    assert_select 'title', "Proposals | #{@base_title}"
  end

  test 'should get new proposal' do
    get new_proposal_url
    assert_response :success
    assert_select 'title', "New proposal | #{@base_title}"
  end
end
