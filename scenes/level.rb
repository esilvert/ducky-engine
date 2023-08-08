class Level < Ducky::Scene
  def initialize
    super

    @background_color = Color.duck_blue

    # Insert your nodes here

    # Scene navigation
    @next_scene = nil # This is mandatory, replace with your next_scene class (Level)
  end

  def complete?
    false
  end

  def must_exit?
    false
  end
end
