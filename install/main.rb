require 'ducky/ducky.rb'

def on_game_start
  $ducky.game_class = Game
end

def require_game_files
  # Lib
  # require 'app/lib/file'

  # Custom nodes
  # require 'app/nodes/custom_nodefrb'

  # Scenes
  require 'ducky/scenes/main_menu'

  # Game
  require 'ducky/game'
end

def tick(args)
  $ducky ||= Ducky.configure

  $ducky.require_game_files_with(&method(:require_game_files))
  $ducky.start_game_with(&method(:on_game_start))

  $ducky.tick(args)
end