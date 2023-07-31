module Ducky
  class Root
    def initialize
      @required_files = false
      @initialized = false
    end

    def tick(args)
      require_game_files and return if should_require_game_files?
      start_game(args) and return if should_start_game?

      @core.system_update(args)
      @core.system_draw(args)
    end

    private

    def should_require_game_files?
      !@required_game_files
    end

    def require_game_files
      log 'Requiring files'

      @require_game_files_block.call
      @required_game_files = true
    end

    def should_start_game?
      !@initialized
    end

    def start_game(args)
      log 'Starting game'

      raise 'Missing game class, please use Ducky#game_class= in game_start callback' if @game_class.nil?

      @core = Engine::Core.new(args, game: @game_class)

      @initialized = true
    end

    def game_class(constant)
      @game_class = constant
    end
  end
end
