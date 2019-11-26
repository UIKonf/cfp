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
end
