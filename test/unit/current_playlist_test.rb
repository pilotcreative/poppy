require "test_helper"

class CurrentPlaylistTest < ActiveSupport::TestCase
  include ActiveModel::Lint::Tests

  def model
    CurrentPlaylist.instance
  end
end
