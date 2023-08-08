module Ducky
  class Physics2D < Node2D
    attr_reader :collision_layer, :shape

    def initialize(position:, collision_layer:, name: "Physics2D##{hash}")
      super(position: position, name: name)

      @collision_layer = collision_layer

      Engine::Physics.register_body(self)
    end

    def on_collision_with(other_layer, &block)
      Engine::Physics.register_collision_handler(self, other_layer, &block)
    end

    def add_shape(shape)
      @shape = add_child(shape)
    end

    def collides_with?(body)
      if @shape.nil? || body.shape.nil?
        log "WARNING: node #{name} is using phyiscs but has no shape"
        return false
      end

      @shape.collides_with?(body.shape)
    end

    def draw(_args); end
  end
end
