module Ducky
  module UsesMouse
    def mouse_position
      Vector2.new(mouse.x, mouse.y)
    end

    def hovered?
      mouse.inside_rect?(AABB.from_2v2(position, size))
    end

    def pressed?
      hovered? && mouse.button_left
    end

    def clicked?
      mouse.click&.inside_rect?(AABB.from_2v2(position, size)) || false
    end

    def included(base)
      return if base.respond_to?(:position) && base.respond_to?(:size)

      raise NotImplementedError, 'Ducky::UsesMouse requires #position and #size methods'
    end

    private

    def mouse
      $gtk.args.inputs.mouse
    end
  end
end
