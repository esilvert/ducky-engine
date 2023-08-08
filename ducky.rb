# Ducky

require 'app/ducky/lib/support.rb'
require 'app/ducky/lib/vector2.rb'
require 'app/ducky/lib/color.rb'
require 'app/ducky/lib/aabb.rb'
require 'app/ducky/lib/input.rb'
require 'app/ducky/lib/node.rb'
require 'app/ducky/lib/fsm.rb'

require 'app/ducky/lib/interfaces/uses_mouse.rb'

require 'app/ducky/lib/engines/initializer.rb'
require 'app/ducky/lib/engines/core.rb'
require 'app/ducky/lib/engines/physics.rb'
require 'app/ducky/lib/root.rb'

require 'app/ducky/lib/nodes/node_2d.rb'
require 'app/ducky/lib/nodes/label.rb'
require 'app/ducky/lib/nodes/sprite.rb'
require 'app/ducky/lib/nodes/button.rb'
require 'app/ducky/lib/nodes/physics_2d.rb'
require 'app/ducky/lib/nodes/static_body.rb'
require 'app/ducky/lib/nodes/kinematic_body.rb'
require 'app/ducky/lib/nodes/shape.rb'
require 'app/ducky/lib/nodes/rectangle_shape.rb'

require 'app/ducky/lib/game.rb'
require 'app/ducky/lib/scene.rb'

class Object
  def log(msg)
    @@indent ||= 0

    if block_given?
      puts "#{"\t" * @@indent} [#{self.class.name}]  #{msg}"
      @@indent += 1
      yield
      @@indent -= 1
      puts "#{"\t" * @@indent} [#{self.class.name}] -- ENDED (#{msg})"
    else
      puts "#{"\t" * @@indent} [#{self.class.name}] #{msg}"
    end
  end
end

module Ducky
  SCREEN_WIDTH  = 1280 # 540 for portrait
  SCREEN_HEIGHT = 720 # 960 for portrait
  DELTA_TIME = 1.0 / 60.0

  def self.configure
    Root.new
  end

  def self.reload
    p '[Ducky] Reloading the whole game'
    $ducky = nil
    clear_all
  end

  def self.clear_all
    Ducky::Scene.clear
    Input.clear
    Engine::Physics.clear
    $gtk.stop_music # DEPRECATED
  end
end

p '[Ducky] Source files have been loaded'
