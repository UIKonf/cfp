# frozen_string_literal: true

require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
    @user = User.new(name: 'Vincent',
                     public_name: 'e941768a902679',
                     email: 'vincent.garrigues@gmail.com',
                     github_uid: 'gh_uid',
                     github_nickname: 'garriguv')
  end

  test 'should be valid' do
    assert @user.valid?
  end

  test 'name should be present' do
    @user.name = '        '
    assert_not @user.valid?
  end

  test 'public_name should be present' do
    @user.public_name = '        '
    assert_not @user.valid?
  end

  test 'email should be present' do
    @user.email = '        '
    assert_not @user.valid?
  end

  test 'github_uid should be present' do
    @user.github_uid = '      '
    assert_not @user.valid?
  end

  test 'github_nickname should be present' do
    @user.github_nickname = '        '
    assert_not @user.valid?
  end

  test 'public_name should be unique' do
    duplicate = @user.dup
    @user.save
    assert_not duplicate.valid?
  end

  test 'email should be unique' do
    duplicate = @user.dup
    duplicate.email = @user.email.upcase
    @user.save
    assert_not duplicate.valid?
  end

  test 'github_uid should be unique' do
    duplicate = @user.dup
    duplicate.github_uid = @user.github_uid.upcase
    @user.save
    assert_not duplicate.valid?
  end

  test 'saves email as lowercase' do
    @user.email = 'Vincent@Example.com'
    @user.save
    assert_equal 'vincent@example.com', @user.reload.email
  end

  test 'create_with_omniauth' do
    auth_hash = {
        uid: 'the_uid',
        info: {
            name: 'User Name',
            email: 'email@example.com',
            nickname: '@nickname'
        }
    }
    auth_user = User.create_with_omniauth(auth_hash)
    assert auth_user.valid?
  end

  test 'create with omniauth without name' do
    auth_hash = {
      uid: 'the_uid',
      info: {
        email: 'email@example.com',
        nickname: '@nickname'
      }
    }
    auth_user = User.create_with_omniauth(auth_hash)
    assert auth_user.valid?
  end

  test 'destroys proposal' do
    @user.save
    @user.proposals.create!(title: 't' * 5, description: 'b' * 250)

    assert_difference 'Proposal.count', -1 do
      @user.destroy
    end
  end

  test 'destroys comments' do
    @user.save
    @proposal = proposals(:one)
    @proposal.comments.create!(body: 'b' * 60, user_id: @user.id)
    @proposal.comments.create!(body: 'c' * 60, user_id: @user.id)

    assert_difference 'Comment.count', -2 do
      @user.destroy
    end
  end

  test 'destroys selections' do
    @user.save
    @proposal = proposals(:one)
    selection = Selection.create!(user: @user, proposal: @proposal)

    assert_difference 'Selection.count', -1 do
      @user.destroy
    end
  end

  test 'block! blocks user' do
    @user.block!('testing')
    assert @user.blocked
  end

  test 'block! sets block_reason' do
    reason = 'a good reason'
    @user.block!(reason)
    assert @user.block_reason == reason
  end

  test 'unblock! unblocks user' do
    @user.block!('reason')
    @user.unblock!
    assert_not @user.blocked
  end

  test 'unblock! removes reason' do
    @user.block!('reason')
    @user.unblock!
    assert_nil @user.block_reason
  end
end
