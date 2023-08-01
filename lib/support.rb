module Ducky
  module ViewportSupport
    def vw
      ratio = to_f / 100.0
      SCREEN_WIDTH * ratio
    end

    def vh
      ratio = to_f / 100.0
      SCREEN_HEIGHT * ratio
    end

    Numeric.include(self)
    String.include(self)
  end

  module MathSupport
    def lerp(from, to, progress)
      from + ((to - from) * progress.clamp(0, 1))
    end

    Object.include(self)
  end
end
