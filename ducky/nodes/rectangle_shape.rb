module Ducky
  class RectangleShape < Shape

    def collides_with?(shape)
      raise NotImplementedError, 'Shape#collides_with? only support collision with another rectangle shape for now' unless shape.is_a?(RectangleShape)

      $gtk.args.geometry.intersect_rect?(to_dr, shape.to_dr)
    end

    def to_dr
      [position.x, position.y, @w, @h]
    end
  end
end
