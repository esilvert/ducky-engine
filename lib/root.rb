module Ducky
  class Root
    def initialize
      @required_files = false
      @initializer = Engine::Initializer.new
    end

    def tick(args)
      if @initializer.pending?
        @initializer.tick

        start_game(args) if @initializer.done?
      else
        @core.tick(args)
      end
    end

    private

    def start_game(args)
      log '[Root] Starting game'

      @core = Engine::Core.new(args, game: ::Game)
    end
  end
end
