module Ducky
  class Input
    class UnknownKey < StandardError; end

    module ClassMethods
      def instance
        @instance ||= self.new
      end

      def register_action(action_id, *inputs)
        instance.register_action(action_id, *inputs)
      end

      def action_just_pressed?(action_id)
        instance.action_just_pressed?(action_id)
      end

      def action_pressed?(action_id)
        instance.action_pressed?(action_id)
      end

      def action_just_released?(action_id)
        instance.action_just_released?(action_id)
      end

      def action_released?(action_id)
        instance.action_released?(action_id)
      end

      def key_down?(key)
        instance.key_down?(key)
      end

      def input_just_pressed?(key)
        instance.input_just_pressed?(key)
      end

      def input_pressed?(key)
        instance.input_pressed?(key)
      end

      def input_just_released?(key)
        instance.input_just_released?(key)
      end

      def input_released?(key)
        instance.input_released?(key)
      end

      def clear
        instance.clear
      end
    end
    extend ClassMethods

    def register_action(action_id, *inputs)
      assert_valid_inputs!(inputs)

      @actions[action_id] += inputs
      log "Actions #{action_id} now bounded to #{@actions[action_id]}"
    end

    def action_just_pressed?(action_id)
      inputs = @actions[action_id]

      inputs.any? { |input| input_just_pressed?(input) }
    end

    def action_pressed?(action_id)
      inputs = @actions[action_id]

      inputs.any? { |input| input_pressed?(input) }
    end

    def input_just_pressed?(key)
      $gtk.args.inputs.keyboard.key_down.send(key)
    end

    def input_pressed?(key)
      $gtk.args.inputs.keyboard.send(key)
    end

    def input_just_released?(key)
      $gtk.args.inputs.keyboard.key_up.send(key)
    end

    def input_released?(key)
      !input_pressed?(key)
    end

    def clear
      @actions = Hash.new { |hash, new_key| hash[new_key] = [] }
    end

    private

    def initialize
      clear
    end

    def assert_valid_inputs!(inputs)
      invalid_inputs = inputs.reject { |input| valid_keys.include?(input) }

      unless invalid_inputs.empty? || true # TODO: Record somewhere all posible inputs
        p valid_keys
        raise UnknownKey, "Ducky does not know the inputs: #{invalid_inputs}"
      end
    end

    def valid_keys
      @valid_keys ||= $gtk.args.inputs.keyboard.keys.keys
    end
  end
end
