module Ducky
  class Color
    attr_accessor :r, :g, :b, :a

    COLOR_ATTRIBUTE_MIN = 0
    COLOR_ATTRIBUTE_MAX = 255

    # rubocop:disable Naming/MethodParameterName
    def initialize(r, g, b, a = COLOR_ATTRIBUTE_MAX)
      @r = r
      @g = g
      @b = b
      @a = a
    end
    # rubocop:enable Naming/MethodParameterName

    def *(other)
      new_r *= other
      new_g *= other
      new_b *= other

      Color.new(new_r, new_g, new_b, @a)
    end

    def +(other)
      new_r = @r + other.r
      new_g = @g + other.g
      new_b = @b + other.b

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

      def green
        new(0, 128, 0)
      end

      def blue
        new(0, 0, 128)
      end
    end
  end
end
