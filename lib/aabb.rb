module Ducky
  module AABB
    def self.from_2v2(pos, size)
      #new(x: pos.x, y: pos.y, w: size.x, h: size.y)
      [pos.x, pos.y, size.x, size.y]
    end
  end
end
