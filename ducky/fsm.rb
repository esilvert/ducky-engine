module Ducky
  class FSM
    attr_accessor :next_state

    attr_reader :previous_state, :current_state

    def initialize(root:, states: [])
      @states = states
      @previous_state = nil
      @current_state = states.first
      @next_state = nil
      @state_duration = 0
      @root = root
    end

    def update
      if @next_state
        @previous_state = @current_state
        @current_state = @next_state
        @next_state = nil
        @state_duration = 0

        state_method = "on_state_#{current_state.to_s.downcase}"

        if @root.respond_to?(state_method)
          @root.send(state_method)
        end
      end

      state_method = "state_#{current_state.to_s.downcase}"
      if @root.respond_to?(state_method)
        @root.send(state_method)
      else
        raise NameError, "FSM is in state #{@current_state} but there is no ##{state_method} defined in root #{@root}"
      end

      @state_duration += @root.delta_time
    end

    def states
      raise NotImplementedError, 'Ducky::FSM#states must be override'
    end

    def states=(val)
      raise ArgumentError, "unknown state #{val}, possible states are #{states}" unless states.include?(val)

      @states = val
      @previous_state = nil
      @current_state = @states.first
      @next_state = nil
    end
  end
end
