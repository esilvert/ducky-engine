# Ducky

require 'ducky/support.rb'
require 'ducky/vector2.rb'
require 'ducky/color.rb'
require 'ducky/aabb.rb'
require 'ducky/input.rb'
require 'ducky/node.rb'
require 'ducky/fsm.rb'

require 'ducky/interfaces/uses_mouse.rb'

require 'ducky/root.rb'
require 'ducky/engines/core.rb'
require 'ducky/engines/physics.rb'

require 'ducky/nodes/node_2d.rb'
require 'ducky/nodes/label.rb'
require 'ducky/nodes/sprite.rb'
require 'ducky/nodes/button.rb'
require 'ducky/nodes/physics_2d.rb'
require 'ducky/nodes/static_body.rb'
require 'ducky/nodes/kinematic_body.rb'
require 'ducky/nodes/shape.rb'
require 'ducky/nodes/rectangle_shape.rb'

require 'ducky/game.rb'
require 'ducky/scene.rb'

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
