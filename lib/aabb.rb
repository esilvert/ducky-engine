module Ducky
  module AABB
    def self.from_2v2(pos, size)
      [pos.x, pos.y, size.x, size.y]
    end
  end
end
