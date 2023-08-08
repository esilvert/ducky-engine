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
      GRID_CONTAINER = :primitive
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
      instance_variables.to_h { |var| [var, instance_variable_get(var)] }
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

    # Called generically by the system
    def system_update(args)
      return unless processing

      ducky_update(args) # Used internally by ducky nodes
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

    def draw(args); end

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
      time_scale * DELTA_TIME
    end

    def print_tree(indent: 0)
      puts "#{'-' * indent}[#{self.class.name}] #{name} #{disabled? ? '(disabled)' : ''} [children: #{active_children.count}]"

      active_children.each do |child|
        child.print_tree(indent: indent + 2)
      end

      nil
    end

    private

    def active_children
      @children.reject(&:disabled?)
    end
  end
end
