class Playlist
  extend ActiveModel::Naming

  attr_accessor :name
  @exist = false
  def initialize(name, exist = false)
    @name = name
    @original_name = name
    @name_changed = false
    @exist = exist
  end

  def self.all
    Player.instance.list_playlists
  end

  def self.current_playlist_songs
    Player.instance.current_playlist_songs
  end

  def self.songs
    Player.instance.list_playlist_info(@name)
  end

  def name=(name)
    @name = name
    @name_changed = true
  end

  def save
    if @name_changed && @exist
      Player.instance.rename_playlist(@original_name, @name)
      @original_name = @name
    elsif !@exist
      Player.instance.create_playlist(@name)
    end
    @name_changed = false
    @exist = true
  end

  def add(path)
    Player.instance.add_to_playlist(path, @name)
    @exist = true
  end

  def clear!
    Player.instance.clear!(@name)
  end

  def destroy
    Player.instance.destroy_playlist(@name) if @exist
  end
end