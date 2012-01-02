require 'test_helper'

class NewsItemTest < ActiveSupport::TestCase
  def test_should_be_valid
    assert NewsItem.new.valid?
  end
end
