# frozen_string_literal: true
module Ducky
  module Engine
    class Core
      class MissingConfiguration < StandardError; end

      attr_reader :engines, :scenes, :current_scene

      def initialize(_args, game:)
        @engines = {
          physics: Physics.instance
        }
        @scenes = []
        @game = game.new

        p '[Ducky] Core engine has been instantiated'
      end

      def system_update(args)
        @engines.each { |_key, engine| engine.system_update(args) }
        @game.system_update(args)
      end

      def system_draw(args)
        @game.system_draw(args)
      end

      def add_scene(scene_class)
        @scenes << scene_class
      end

      def start_scene(scene, args)
        raise MissingConfiguration, 'You must give at least on scene to Engine::Core' if scene.nil?

        @current_scene = scene.new(args).tap(&:enter_tree)
      end
    end
  end
end
