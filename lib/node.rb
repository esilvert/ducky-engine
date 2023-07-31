module Ducky
  class Node
    class NotANode < StandardError; end

    module Type
      LABEL = :label
      SPRITE = :sprite
      PANEL = :sprite
      BUTTON = :sprite
      STATIC_BODY = :primitive
      KINEMATIC_BODY = :primitive
      BACKGROUND_COLOR = :background_color
    end

    attr_reader :parent, :children, :dead
    attr_accessor :name, :processing, :time_scale

    def initialize(name = "#{self.class.name}##{hash}")
      @name = name
      @children = []
      @disabled = false
      @dead = false
      @processing = true
      @time_scale = 1.0
    end

    def serialize
      res = {}

      return name
    end

    def inspect
      serialize.to_s
    end

    def to_s
      serialize.to_s
    end

    def parent=(node)
      if !node.is_a?(Node) && !node.nil?
        raise NotANode, "Ducky::Node#parent= must receive a Ducky::Node, received <#{node}>"
      end

      @parent = node
    end

    def add_child(node)
      raise NotANode, "Ducky::Node#add_child must receive a Ducky::Node, received <#{node}>" unless node.is_a?(Node)

      @children << node
      node.parent = self

      node
    end

    def system_update(args) # Called generically by the system
      return unless processing

      ducky_update(args) # Uses internally by ducky nodes
      update(args) # Can be overriden by end user
      active_children.each { |child| child.system_update(args) }
    end

    def ducky_update(args); end
    def update(args); end

    def system_draw(args)
      draw(args)
      active_children.each do |node|
        node.system_draw(args)
      end
    end

    def draw(_args)
      # raise NotImplementedError, "You must define a #draw method for node #{name}"
    end

    def disabled?
      @disabled
    end

    def disable=(val)
      if val
        disable!
      else
        enable!
      end
    end

    def disable!
      @disabled = true
    end

    def enable!
      @disabled = false
    end

    def queue_free!
      disable!
      @dead = true
    end

    def delta_time
      time_scale
    end

    private
    def active_children
      @children.reject(&:disabled?)
    end
  end
end
