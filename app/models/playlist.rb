class Playlist
  include ActiveModel::Validations
  extend ActiveModel::Naming

  attr_accessor :name, :exists

  validate do |playlist|
    playlist.errors.add_to_base("Name can't be blank") if playlist.name.blank?
    playlist.errors.add_to_base("Playlist aready exist") if playlist.exists?
  end

  def initialize(name = nil)
    @exists = false
    @name = name
    @player = Player.instance
  end

  def self.all
    Player.instance.list_playlists
  end

  def self.current
    CurrentPlaylist.instance
  end

  def persisted?
    @exists
  end

  def save
    @player.create_playlist(@name) if valid?
  end

  def exists?
    @player.list_playlists.any?{|playlist| playlist.name == @name }
  end

  def songs
    @player.list_playlist_info(@name) unless @name.blank?
  end

  def clear!
    @player.clear!(@name)
  end

  def destroy
    @player.destroy_playlist(@name) if persisted?
  end
end