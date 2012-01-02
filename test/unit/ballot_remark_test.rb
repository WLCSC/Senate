require 'test_helper'

class BallotRemarkTest < ActiveSupport::TestCase
  def test_should_be_valid
    assert BallotRemark.new.valid?
  end
end
