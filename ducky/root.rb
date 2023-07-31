
module Ducky
  class Root
    attr_accessor :game_class

    def initialize
      @required_files = false
      @initialized = false
    end

    def tick(args)
      require_game_files and return if should_require_game_files?
      start_game(args) and return if should_start_game?
      # return if args.gtk.load_state

      @core.system_update(args)
      @core.system_draw(args)
    end

    def require_game_files_with(&block)
      @require_game_files_block = block
    end

    def start_game_with(&block)
      @initialization_block = block
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
      @initialization_block.call

      raise 'Missing game class, please use Ducky#game_class= in game_start callback' if @game_class.nil?

      @core = Engine::Core.new(args, game: @game_class)

      @initialized = true
    end
  end
end
