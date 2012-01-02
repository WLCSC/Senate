require 'test_helper'

class TitleTest < ActiveSupport::TestCase
  def test_should_be_valid
    assert Title.new.valid?
  end
end
