require 'test_helper'

class BallotTest < ActiveSupport::TestCase
  def test_should_be_valid
    assert Ballot.new.valid?
  end
end
