module Ducky
  class Button < Sprite
    include UsesMouse

    DEFAULT_HOVERED_MODULATE = Color.new(255, 255, 255, 230).freeze
    DEFAULT_PRESSED_MODULATE = Color.new(200, 200, 200, 255).freeze

    attr_accessor :size, :text, :hovered_modulate, :pressed_modulate

    attr_reader :state

    # rubocop:disable Metrics/ParameterLists, Metrics/MethodLength
    def initialize(
      position:,
      width:,
      height:,
      text: nil,
      name: "Button##{hash}",
      asset: 'square/blue.png',
      angle: 0,
      modulate: Color.white,
      source_x: 0,
      source_y: 0,
      source_w: -1,
      source_h: -1,
      flip_vertically: false,
      flip_horizontally: false,
      angle_anchor_x: 0.5,
      angle_anchor_y: 1,
      blend_mode: Blending::ALPHA,
      center: true
    )
      super(
        position: position,
        width: width,
        height: height,
        name: name,
        asset: asset,
        angle: angle,
        modulate: modulate,
        source_x: source_x,
        source_y: source_y,
        source_w: source_w,
        source_h: source_h,
        flip_vertically: flip_vertically,
        flip_horizontally: flip_horizontally,
        angle_anchor_x: angle_anchor_x,
        angle_anchor_y: angle_anchor_y,
        blend_mode: blend_mode
      )

      @size = Vector2.new(width, height)

      @local_position -= size * 0.5 if center

      @base_modulate = modulate
      @hovered_modulate = DEFAULT_HOVERED_MODULATE
      @pressed_modulate = DEFAULT_PRESSED_MODULATE

      if text
        @label = add_child(Label.new(text: text))
        @label.fit_text_into(width, height)
      end

      @state = :default
    end
    # rubocop:enable Metrics/ParameterLists, Metrics/MethodLength

    def on_clicked(&block)
      @clicked_callback = block
      self
    end

    def on_hovered(&block)
      @hovered_callback = block
      self
    end

    def on_pressed(&block)
      @pressed_callback = block
      self
    end

    def on_focus_lost(&block)
      @focus_lost_callback = block
      self
    end

    # rubocop:disable Metrics/AbcSize, Metrics/PerceivedComplexity, Metrics/CyclomaticComplexity
    def ducky_update(_args)
      if clicked? # only occur once
        @modulate = @pressed_modulate
        @clicked_callback&.call(self)
        @state = :clicked
      elsif pressed?
        @modulate = @pressed_modulate
        @pressed_callback&.call(self) if @state != :pressed
        @state = :pressed
      elsif hovered?
        @modulate = @hovered_modulate
        @hovered_callback&.call(self) if @state != :hovered
        @state = :hovered
      else
        @modulate = @base_modulate
        @focus_lost_callback&.call(self) if @state != :default
        @state = :default
      end
    end
    # rubocop:enable Metrics/AbcSize, Metrics/PerceivedComplexity, Metrics/CyclomaticComplexity
  end
end
