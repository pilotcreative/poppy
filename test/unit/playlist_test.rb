require "test_helper"

class PlaylistTest < ActiveSupport::TestCase
  include ActiveModel::Lint::Tests

  def model
    Playlist.new("asdas")
  end
end
