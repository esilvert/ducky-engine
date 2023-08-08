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

        @root.send(state_method) if @root.respond_to?(state_method)
      end

      unless @root.respond_to?(current_state_method)
        raise NameError, "FSM is in state #{@current_state} but there is no ##{state_method} defined in root #{@root}"
      end

      @root.send(state_method)

      @state_duration += @root.delta_time
    end

    def states
      raise NotImplementedError, 'Ducky::FSM#states must be override'
    end

    private

    def current_state_method
      "state_#{current_state.to_s.downcase}"
    end
  end
end
