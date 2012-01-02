require 'test_helper'

class ProposalTest < ActiveSupport::TestCase
  def test_should_be_valid
    assert Proposal.new.valid?
  end
end
