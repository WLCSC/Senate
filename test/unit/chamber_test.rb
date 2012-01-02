require 'test_helper'

class ChamberTest < ActiveSupport::TestCase
  def test_should_be_valid
    assert Chamber.new.valid?
  end
end
