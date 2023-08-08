module Ducky
  class Node2D < Node
    dr_type :primitive

    def initialize(position:, name: "Node2D##{hash}")
      super(name)

      @local_position = Vector2.zero

      self.position = position
    end

    def position
      if parent
        parent.position + @local_position
      else
        @local_position
      end
    end

    def position=(pos)
      @local_position = pos
    end
  end
end
