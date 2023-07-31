module Ducky
  class Color
    attr_accessor :r, :g, :b, :a

    COLOR_ATTRIBUTE_MIN = 0
    COLOR_ATTRIBUTE_MAX = 255


    def initialize(r, g, b, a = COLOR_ATTRIBUTE_MAX)
      @r = r
      @g = g
      @b = b
      @a = a
    end

    def *(scalar)
      new_r *= scalar
      new_g *= scalar
      new_b *= scalar

      Color.new(new_r, new_g, new_b, @a)
    end

    def +(color)
      new_r = (@r + color.r).clamp(COLOR_ATTRIBUTE_MIN, COLOR_ATTRIBUTE_MAX)
      new_g = (@g + color.g).clamp(COLOR_ATTRIBUTE_MIN, COLOR_ATTRIBUTE_MAX)
      new_b = (@b + color.b).clamp(COLOR_ATTRIBUTE_MIN, COLOR_ATTRIBUTE_MAX)

      Color.new(new_r, new_g, new_b, @a)
    end

    def serialize
      { r: @r, g: @g, b: @b, a: @a }
    end

    def inspect
      serialize.to_s
    end

    def to_s
      serialize.to_s
    end

    def to_dr
      [@r, @g, @b]
    end

    class << self
      def white
        new(255, 255, 255)
      end

      def black
        new(0, 0, 0)
      end

      def duck_blue
        new(4, 139, 154)
      end

      def one
        new(255, 255, 255, 255)
      end

      def zero
        new(0, 0, 0, 0)
      end

      def red
        new(128, 0, 0)
      end

      def gree
        new(0, 128, 0)
      end

      def blue
        new(0, 0, 128)
      end
    end
  end
end
