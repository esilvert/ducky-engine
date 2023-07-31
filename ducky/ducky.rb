# Ducky

require 'app/ducky/support'
require 'app/ducky/vector2'
require 'app/ducky/color'
require 'app/ducky/aabb'
require 'app/ducky/input'
require 'app/ducky/node'
require 'app/ducky/fsm'

require 'app/ducky/interfaces/uses_mouse'

require 'app/ducky/root'
require 'app/ducky/engines/core'
require 'app/ducky/engines/physics'

require 'app/ducky/nodes/node_2d'
require 'app/ducky/nodes/label'
require 'app/ducky/nodes/sprite'
require 'app/ducky/nodes/button'
require 'app/ducky/nodes/physics_2d'
require 'app/ducky/nodes/static_body'
require 'app/ducky/nodes/kinematic_body'
require 'app/ducky/nodes/shape'
require 'app/ducky/nodes/rectangle_shape'

require 'app/ducky/game'
require 'app/ducky/scene'

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
