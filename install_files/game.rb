class Game < Ducky::Game
  def configuration
    add_scene :main_menu, MainMenu
    # Add your scenes here
    # add_scene :tutorial, DefendTutorial
  end
end
