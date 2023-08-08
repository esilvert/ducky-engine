class SCENE_NAME < Ducky::Scene
  # include Callbacks, found in SCENE_NAME/callbacks.rb for instance

  def initialize
    super
    @background_color = Ducky::Color.black

    # The following is only an example of how you can architecture your scene
    register_static_nodes
    register_ui
    # register_objective
    # register_enemies

    # The two following lines are required
    @next_scene = MainMenu # Change for what scene follows
    @complete = false # Change to true when the scene is complete
    @must_exit = false # Change to true when the game must exit
  end

  def complete?
    @complete
  end

  def must_exit?
    @must_exit
  end

  # The scene is updated, so it can deliver some logic
  # Even though we recommand to put all the logic in the nodes
  # Sometime the scene itself has some stuff to do
  # Uncomment the following lines if you need to use it
  #
  # def update(args)
  #   # Your custom scene logic here
  #   # eg: @must_exit = @player.is_dead?
  # end

  private

  def register_static_nodes
    # Register static nodes here
    # Don't forget the static: true option
  end

  def register_ui
    # Register UI here
  end

  # ...
end
