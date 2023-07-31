module Ducky
  attr_accessor :size
  attr_reader :w, :h
  class Shape < Node2D
    def initialize(position:, size:, name: "Shape##{hash}")
      super(position: position, name: name)
      @size = size
      @w = size.x
      @h = size.y
    end

    def size=(value)
      @size = value
      @w = value.x
      @h = value.y
    end

    def collides_with?(shape)
      raise NotImplementedError, "Shape#collides_with? must be override"
    end

    def draw(args); end
  end
end
