require 'test_helper'

class ModeTest < ActiveSupport::TestCase
  def setup
    @mode = Mode.new(:cfp)
  end

  test 'mode can?' do
    assert @mode.can?(:create, :proposal)
  end

  test 'mode can? return false when rule is not allowed' do
    assert_not @mode.can?(:create, :selection)
  end

  test 'default mode is :cfp' do
    new_mode = Mode.new('')
    assert new_mode.mode == :cfp
  end
end
