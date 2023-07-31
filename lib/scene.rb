module Ducky
  class Scene
    attr_reader :nodes
    attr_reader :next_scene

    def self.clear
      $gtk.args.outputs.static_solids.clear
      $gtk.args.outputs.static_sprites.clear
      $gtk.args.outputs.static_primitives.clear
      $gtk.args.outputs.static_labels.clear
      $gtk.args.outputs.static_lines.clear
      $gtk.args.outputs.static_borders.clear
      $gtk.args.outputs.static_debug.clear
    end

    def initialize
      @nodes = []
      @static_nodes = Hash.new { |hash, new_key| hash[new_key] = [] }
      @background_color = Color.white
    end

    def enter_tree
      output_static_nodes
    end

    def system_update(args)
      update(args)
      active_nodes.each { |node| node.system_update(args) }
      purge_nodes!
    end

    def update(args); end

    def system_draw(args)
      draw(args)
      active_nodes.each do |node|
        node.system_draw(args)
      end
    end

    def draw(args)
      args.outputs.background_color = @background_color.to_dr
    end

    def complete?
      false
    end

    def must_exit?
      false
    end

    def register_node(node)
      @nodes << node

      yield node if block_given?

      node
    end

    # Define all register_* node methods
    Node::Type.constants.each do |const|
      type_value = Node::Type.const_get(const)
      normalized_type_name = const.to_s.downcase

      log "Defining method register_#{normalized_type_name}"
      normalized_type = type_value.to_s.downcase

      define_method("register_#{normalized_type_name}") do |node, **options|
        # unless node.is_a?(Node)
        #   raise Node::NotANode,
        #         "Ducky::Scene##{__method__} must receive a Ducky::Node, received <#{node}>"
        # end

        if options[:static]
          @static_nodes[normalized_type] << node
        else
          @nodes << node
        end

        yield node if block_given?

        node
      end
    end

    protected

    def output_static_nodes
      outputs = $gtk.args.outputs

      @static_nodes.each do |type, nodes|
        next if nodes.empty?
        nodes_dr = nodes.map(&:to_dr)

        # solids, sprite, primitive, label, line, border, debug
        case type.to_sym
        when :solid     then outputs.static_solids << nodes_dr
        when :sprite    then outputs.static_sprites << nodes_dr
        when :primitive then outputs.static_primitives << nodes_dr
        when :label     then outputs.static_labels << nodes_dr
        when :line      then outputs.static_lines << nodes_dr
        when :border    then outputs.static_borders << nodes_dr
        when :debug     then outputs.static_debugs << nodes_dr
        else raise Node::NotANode, "Registered an unknown type of static_node : #{type}"
        end
      end
    end

    def exit_tree
      Ducky.clear_all
    end

    private
    def active_nodes
      @nodes.reject(&:disabled?)
    end

    def purge_nodes!
      @nodes.reject!(&:dead)
    end
  end
end
