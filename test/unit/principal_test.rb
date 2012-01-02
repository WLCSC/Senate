require 'test_helper'

class PrincipalTest < ActiveSupport::TestCase
  def test_should_be_valid
    assert Principal.new.valid?
  end
end
