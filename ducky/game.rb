module Ducky
  class Game
    def initialize
      @scenes = {}

      log 'Configuring scenes'
      configuration

      raise 'You must add at least one scene during the game configuration' if @scenes.empty?

      start_scene(@scenes.first[1])
    end

    def configuration
      raise NotImplementedError, 'You must rewrite Game#configuration'
    end

    def add_scene(id, scene_class)
      @scenes[id] = scene_class
    end

    def start_scene(scene_class)
      log "Starting new scene #{scene_class}"
      @scene = scene_class.new.tap(&:enter_tree)
    end

    def system_update(args)
      @scene.system_update(args)

      if @scene.complete?
        on_scene_complete
      elsif @scene.must_exit?
        $gtk.request_quit
      end
    end

    def system_draw(args)
      @scene.system_draw(args)
    end

    private

    def on_scene_complete
      unless @scene.next_scene
        log "The current scene #{@scene.class.name} is complete but has no #next_scene. Scene navigation stopped."
        return
      end

      @scene.exit_tree

      start_scene(@scene.next_scene)
    end
  end
end
