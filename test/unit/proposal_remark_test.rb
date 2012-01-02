require 'test_helper'

class ProposalRemarkTest < ActiveSupport::TestCase
  def test_should_be_valid
    assert ProposalRemark.new.valid?
  end
end
