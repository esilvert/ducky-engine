module Ducky
  module Engine
    class Physics
      module ClassMethods
        def instance
          @instance ||= new
        end

        def register_body(body)
          instance.register_body(body)
        end

        def register_collision_handler(first_body_type, other_body_type, &block)
          instance.register_collision_handler(first_body_type, other_body_type, &block)
        end

        def clear
          instance.clear
        end
      end
      extend ClassMethods

      def register_body(body)
        raise ArgumentError, 'Physics#register_body must receive a Ducky::Physics2D' unless body.is_a?(Physics2D)

        log "Registered a body #{body.class.name} (#{@bodies.count + 1})"
        @bodies << body
      end

      def register_collision_handler(node, other_body_type, &block)
        log "Registered collision handler between #{node.name} and #{other_body_type}"

        @collision_handlers[node][other_body_type] << block
      end

      # Naive
      def system_update(_args)
        bodies_that_collide = @collision_handlers.keys

        new_collisions = bodies_that_collide.filter_map do |kinematic|
          kinematic_collisions = active_bodies.select { |body| collides?(kinematic, body) }
          next if kinematic_collisions.empty?

          [kinematic, kinematic_collisions]
        end

        new_collisions.each do |body, collisions|
          collisions.each { |collision| notify_collision(body, collision) }
        end

        purge!
      end

      def clear
        @bodies = []
        @collision_handlers = Hash.new do |node_hash, new_node|
          node_hash[new_node] = Hash.new { |layer_hash, new_layer| layer_hash[new_layer] = [] }
        end
      end

      private

      def initialize
        clear
      end

      def collides?(first_body, other_body)
        first_body != other_body && first_body.collides_with?(other_body)
      end

      def notify_collision(body, other_body)
        key1 = body.collision_layer
        key2 = other_body.collision_layer

        collision = { key1 => body, key2 => other_body }

        @collision_handlers[body][key2].each { |handler| handler.call(collision) } if @collision_handlers.key?(body)

        return unless @collision_handlers.key?(other_body)

        @collision_handlers[other_body][key1].each do |handler|
          handler.call(collision)
        end
      end

      def active_bodies
        @bodies.reject(&:disabled?)
      end

      def kinematic_bodies
        active_bodies.select { |body| body.is_a?(KinematicBody) }
      end

      def purge!
        purge_handlers
        purge_bodies
      end

      def purge_handlers
        @collision_handlers.reject! { |node, _| node.dead }
      end

      def purge_bodies
        @bodies.reject!(&:dead)
      end
    end
  end
end
