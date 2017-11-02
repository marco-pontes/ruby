class Song
  include Comparable
  attr_accessor :name, :quality, :length

  def initialize(name, quality, length)
    @name = name
    @quality = quality
    @length = length
  end

  def <=>(other)
    @quality <=> other.quality
  end
end