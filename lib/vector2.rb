module Ducky
  class Vector2
    attr_accessor :x, :y

    def initialize(x, y)
      if x.is_a?(String)
        @x = x.vw
      else
        @x = x
      end

      if y.is_a?(String)
        @y = y.vh
      else
        @y = y
      end
    end

    def +(other)
      Vector2.new(@x + other.x, @y + other.y)
    end

    def -(other)
      Vector2.new(@x - other.x, @y - other.y)
    end

    def *(other)
      Vector2.new(@x * other, @y * other)
    end

    def magnitude
      Math.sqrt(@x.to_f ** 2 + @y.to_f ** 2)
    end

    def normalized
      self_magnitude = magnitude

      if self_magnitude.zero?
        Vector2.zero
      else
        Vector2.new(@x / self_magnitude, @y / self_magnitude)
      end
    end

    def ==(other)
      @x == other.x && @y == other.y
    end

    def serialize
      {x: @x, y: @y}
    end

    def inspect
      serialize.to_s
    end

    def to_s
      serialize.to_s
    end

    class << self
      def zero
        new(0, 0)
      end

      def one
        new(1, 1)
      end

      def right
        new(1, 0)
      end

      def left
        new(-1, 0)
      end

      def up
        new(0, 1)
      end

      def down
        new(0, -1)
      end

      def random
        new(rand(2.0) - 1, rand(2.0) - 1).normalized
      end

      def screen_center
        new(50.vw, 50.vh)
      end
    end
  end
end
