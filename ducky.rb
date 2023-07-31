# Ducky

require 'ducky/lib/support.rb'
require 'ducky/lib/vector2.rb'
require 'ducky/lib/color.rb'
require 'ducky/lib/aabb.rb'
require 'ducky/lib/input.rb'
require 'ducky/lib/node.rb'
require 'ducky/lib/fsm.rb'

require 'ducky/lib/interfaces/uses_mouse.rb'

require 'ducky/lib/engines/initializer.rb'
require 'ducky/lib/engines/core.rb'
require 'ducky/lib/engines/physics.rb'
require 'ducky/lib/root.rb'

require 'ducky/lib/nodes/node_2d.rb'
require 'ducky/lib/nodes/label.rb'
require 'ducky/lib/nodes/sprite.rb'
require 'ducky/lib/nodes/button.rb'
require 'ducky/lib/nodes/physics_2d.rb'
require 'ducky/lib/nodes/static_body.rb'
require 'ducky/lib/nodes/kinematic_body.rb'
require 'ducky/lib/nodes/shape.rb'
require 'ducky/lib/nodes/rectangle_shape.rb'

require 'ducky/lib/game.rb'
require 'ducky/lib/scene.rb'

class Object
  def log(msg)
    p "[#{self.class.name}] #{msg}"
  end
end

module Ducky
  SCREEN_WIDTH  = 1280
  SCREEN_HEIGHT = 720
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
