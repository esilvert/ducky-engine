# frozen_string_literal: true

module Ducky
  module Engine
    class Initializer
      def tick
        require_game_files and return unless @files_loaded
        run_custom_init and return unless @initialization_complete
      end

      def pending?
        !@files_loaded || !@initialization_complete
      end

      def done?
        !pending?
      end

      def custom_init(&block)
        @custom_init = block
      end

      private

      def require_game_files
        log '[Root] Requiring files'

        require 'app/lib.rb'
        require 'app/models.rb'
        require 'app/scenes.rb'

        require 'app/game.rb'

        @files_loaded = true
      end

      def run_custom_init
        log '[Root] Running custom init'

        instance_eval(&@custom_init) unless @custom_init.nil?
        @initialization_complete = true
      end
    end
  end
end
