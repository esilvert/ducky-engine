module Ducky
  class Label < Node2D
    dr_type :label

    DEFAULT_FONT_SIZE = 2
    DEFAULT_FONT = 'fonts/manaspc.ttf'.freeze

    module TextAlign
      LEFT = 0
      CENTER = 1
      RIGHT = 2
    end

    module TextVerticalAlign
      BOTTOM = 0
      CENTER = 1
      TOP = 2
    end

    attr_reader :text
    attr_accessor(*%i[size align font vertical_align color])

    # rubocop:disable Metrics/ParameterLists
    def initialize(
      text:, position: Vector2.zero,
      name: "Label##{hash}",
      size: DEFAULT_FONT_SIZE,
      align: TextAlign::CENTER,
      vertical_align: TextVerticalAlign::CENTER,
      font: DEFAULT_FONT,
      color: Color.duck_blue
    )
      super(position: position, name: name)

      @text = text
      @size = size
      @align = align
      @vertical_align = vertical_align
      @font = font
      @color = color
      @base_text = text
    end
    # rubocop:enable Metrics/ParameterLists

    def restore_text
      self.text = @base_text
    end

    def text=(value)
      @text = value

      fit_text_into(@fit_in.x, @fit_in.y, allow_growth: @fit_allow_growth) if @fit_in
    end

    def text_size
      width, height = $gtk.calcstringbox(@text, @size, DEFAULT_FONT)

      Vector2.new(width, height)
    end

    # rubocop:disable Metrics/AbcSize
    def fit_text_into(width, height, allow_growth: false)
      @fit_in = Vector2.new(width, height)
      @fit_allow_growth = allow_growth

      @size = if allow_growth
                width / text_size.x
              else
                (width / text_size.x).clamp(0, @size)
              end

      @local_position.x += width / 2
      @local_position.y += (height / 2) + (text_size.y / 2)
    end
    # rubocop:enable Metrics/AbcSize

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

    def draw(args)
      args.outputs.labels << to_dr
    end
  end
end
