require "test_helper"

class SongTest < ActiveSupport::TestCase
  include ActiveModel::Lint::Tests

  def model
    Song.new({:artist => "foo", :title => "bar", :time => "baz", :date => "2010-08-11", :genre => "test", :file => "asd"})
  end
end
