module Ducky
  class Scene
    attr_reader :nodes, :next_scene, :background_color

    def self.clear
      outputs = $gtk.args.outputs

      [
        outputs.static_solids,
        outputs.static_sprites,
        outputs.static_primitives,
        outputs.static_labels,
        outputs.static_lines,
        outputs.static_borders,
        outputs.static_debug
      ].each(&:clear)
    end

    def initialize
      reset
    end

    def reset
      @nodes = []
      @static_nodes = Hash.new { |hash, new_key| hash[new_key] = [] }
      @background_color = Color.white
    end

    def enter_tree
      draw_static_nodes
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
      args.outputs.background_color = background_color.to_dr
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

    def print_tree
      puts "\n" * 2
      puts "Printing tree for #{self.class.name}"
      puts "Nodes: #{nodes.count}"

      puts "Root (#{self.class.name})"

      nodes.each do |node|
        node.print_tree(indent: 2)
      end

      puts "End of tree for #{self.class.name}" + ("\n" * 2)
    end

    protected

    # rubocop:disable Metrics/AbcSize, Metrics/CyclomaticComplexity
    def draw_static_nodes
      outputs = $gtk.args.outputs

      @static_nodes.reject(&:empty?).each do |type, nodes|
        nodes_dr = nodes.map(&:to_dr)

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
    # rubocop:enable Metrics/AbcSize, Metrics/CyclomaticComplexity

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
