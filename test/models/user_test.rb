# frozen_string_literal: true

require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
    @user = User.new(name: 'Vincent',
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
end
