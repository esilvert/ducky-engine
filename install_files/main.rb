require 'ducky/ducky.rb'

def tick(args)
  $ducky ||= Ducky.configure do
    game_class Game
  end

  $ducky.tick(args)
end
