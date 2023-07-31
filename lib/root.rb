module Ducky
  class Root
    def initialize
      @required_files = false
      @initialized = false
    end

    def tick(args)
      require_game_files and return unless @required_game_files
      run_custom_init and return unless @custom_initialized
      start_game(args) and return unless @initialized

      @core.system_update(args)
      @core.system_draw(args)
    end

    private

    def require_game_files
      log '[Root] Requiring files'

      require 'app/lib.rb'
      require 'app/models.rb'
      require 'app/scenes.rb'

      require 'app/game.rb'

      @required_game_files = true
    end

    def start_game(args)
      log '[Root] Starting game'

      raise 'Missing game class, please use Ducky#game_class= in game_start callback' if @game_class.nil?

      @core = Engine::Core.new(args, game: @game_class)

      @initialized = true
    end

    def custom_init(&block)
      @custom_init = block
    end

    def run_custom_init
      log '[Root] Running custom init'

      instance_eval(&@custom_init) unless @custom_init.nil?
      @custom_initialized = true
    end

    def game_class(constant)
      @game_class = constant
    end
  end
end
