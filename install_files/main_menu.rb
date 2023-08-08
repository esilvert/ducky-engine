class MainMenu < Ducky::Scene
  def initialize
    super
    @background_color = Ducky::Color.black

    register_node(
      Ducky::Label.new(
        text: 'Ducky Engine',
        position: Ducky::Vector2.new('50%', '80%'),
        size: 15
      ),
      static: true
    )
    @play_button = register_node(play_button)
                   .on_clicked do
      @next_scene = MainMenu
      @complete = true
    end
    @tutorial_button = register_node(tutorial_button)
                       .on_clicked do
      @next_scene = MainMenu
      @complete = true
    end
    @exit_button = register_node(exit_button)

    @next_scene = MainMenu
    @complete = false

    # register_node(Panel.new(size: Ducky::Vector2.new(10000,800)), static: true)
  end

  def complete?
    @complete
  end

  def must_exit?
    @exit_button&.clicked?
  end

  private

  def play_button
    Ducky::Button.new(
      position: Ducky::Vector2.new(50.vw, 50.vh),
      width: 85.vw,
      height: 100,
      text: 'Play !',
      asset: 'square/blue.png'
    )
  end

  def tutorial_button
    Ducky::Button.new(
      position: Ducky::Vector2.new('30%', '30%'),
      width: 40.vw,
      height: 100,
      text: 'Tutorial',
      asset: 'square/green.png'
    )
  end

  def exit_button
    Ducky::Button.new(
      position: Ducky::Vector2.new('70%', '30%'),
      width: 40.vw,
      height: 100,
      text: 'Exit',
      asset: 'square/red.png'
    )
  end
end
