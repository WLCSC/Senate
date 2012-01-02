require 'test_helper'

class BoardTest < ActiveSupport::TestCase
  def test_should_be_valid
    assert Board.new.valid?
  end
end
