module Ducky
  class GridContainer < Node2D
    DEFAULT_COLUMN_COUNT = 2
    DEFAULT_CELL_GAP = Vector2.one * 5

    def initialize(
      width:,
      height:,
      name: "Label##{hash}",
      position: Vector2.zero,
      columns: DEFAULT_COLUMN_COUNT,
      cell_gap: DEFAULT_CELL_GAP
    )
      super(position: position, name: name)

      @columns = columns
      @width = width
      @height = height
      @cell_gap = cell_gap
      @cell_step_w = @width / @columns
    end

    def to_dr
      {
        x: position.x,
        y: position.y,
        text: @text,
        size_enum: @size,
        alignment_enum: @align,
        r: @color.r,
        g: @color.g,
        b: @color.b,
        a: @color.a,
        font: @font,
        vertical_alignment_enum: @vertical_align
      }
    end

    def add_child(node)
      super
      update_children_position
      node
    end

    private

    def update_children_position
      cells = active_children

      @row_count = (cells.size.to_f / @columns).ceil
      @cell_step_h = @height / @row_count

      cells.each.with_index do |child, index|
        update_child_position(child, index)
      end
    end

    def update_child_position(child, index)
      row = index.div(@columns)
      col = index % @columns

      x = col * (@cell_step_w + @cell_gap.x)
      y = @height - (row * (@cell_step_h + @cell_gap.y))
      y -= child.height if child.respond_to?(:height)

      child.position = Vector2.new(x, y)
    end
  end
end
