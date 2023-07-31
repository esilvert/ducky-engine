module Ducky
  class Sprite < Node2D
    SPRITE_DIR = 'sprites/'.freeze

    attr_accessor(*%i[
                   width
                   height
                   asset
                   angle
                   modulate
                   source_x
                   source_y
                   source_w
                   source_h
                   flip_vertically
                   flip_horizontally
                   angle_anchor_x
                   angle_anchor_y
                   blend_mode
                 ])

    # 0 (no blending), 1 (alpha blending), 2 (additive blending), 3 (modulo blending), 4 (multiply blending).
    module Blending
      NONE = 0
      ALPHA = 1
      ADDITIVE = 2
      MODULE = 3
      MULTIPLY = 4
    end

    def initialize(
      position:,
      width:,
      height:,
      name: "Sprite##{hash}",
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
      blend_mode: Blending::NONE
    )
      super(position: position, name: name)

      @width = width
      @height = height
      @asset = asset
      @angle = angle
      @modulate = modulate
      @source_x = source_x
      @source_y = source_y
      @source_w = source_w
      @source_h = source_h
      @flip_horizontally = flip_horizontally
      @flip_vertically = flip_vertically
      @angle_anchor_x = angle_anchor_x
      @angle_anchor_y = angle_anchor_y
      @blend_mode = blend_mode
    end

    def to_dr
      {
        x: position.x,
        y: position.y,
        w: @width,
        h: @height,
        path: SPRITE_DIR + @asset,
        angle: @angle,
        r: @modulate.r,
        g: @modulate.g,
        b: @modulate.b,
        a: @modulate.a,
        source_x: @source_x,
        source_y: @source_y,
        source_w: @source_w,
        source_h: @source_h,
        flip_vertically: @flip_vertically,
        flip_horizontally: @flip_horizontally,
        angle_anchor_x: @angle_anchor_x,
        angle_anchor_y: @angle_anchor_y,
        blendmode_enum: @blend_mode
      }
    end

    def draw(args)
      args.outputs.sprites << to_dr
    end
  end
end
