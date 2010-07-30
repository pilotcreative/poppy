class Song
  include ActiveModel::AttributeMethods
  extend ActiveModel::Naming

  attr_reader :attributes
  attribute_method_suffix ""
  attribute_method_suffix "="

  define_attribute_methods [:title, :file]

  def initialize(player = Player.instance, attributes={})
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

  def attributes(name)
    @attributes[name]
  end

  def attributes=(name, value)
    @attributes[name] = value
  end
end
