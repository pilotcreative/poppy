class Song
  include ActiveModel::AttributeMethods
  extend ActiveModel::Naming

  attr_reader :attributes
  attribute_method_suffix ""
  attribute_method_suffix "="

  define_attribute_methods [:artist, :title, :time, :date, :album, :genre, :file]

  def initialize(attributes, player = Player.instance)
    @player = player.mpc
    @attributes = attributes.with_indifferent_access
  end

  def find(type, what="")
    @player.find(type, what)
  end

  def all
    @player.listall
  end

  def current
    @player.current_song
  end

  protected

  def attribute(name)
    @attributes[name]
  end

  def attribute=(name, value)
    @attributes[name] = value
  end
end
