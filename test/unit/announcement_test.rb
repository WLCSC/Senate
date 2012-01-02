require 'test_helper'

class AnnouncementTest < ActiveSupport::TestCase
  def test_should_be_valid
    assert Announcement.new.valid?
  end
end
