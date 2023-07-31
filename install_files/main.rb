require 'ducky/ducky.rb'

def require_game_files
  require 'app/lib.rb'
  require 'app/models.rb'
  require 'app/scenes.rb'

  require 'ducky/game'
end

def tick(args)
  $ducky ||= Ducky.configure do
    game_class Game
  end

  $ducky.tick(args)
end
