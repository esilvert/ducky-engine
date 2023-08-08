ducky_dir = mygame/app/ducky
application_dir = mygame/app
template_dir = $(ducky_dir)/templates
destination_dir = $(application_dir)

run_game:
	./dragonruby

update_ducky:
	cd $(ducky_dir) && git pull && make install && cd -

clear_logs:
	rm -r logs/

new_scene:
	@echo "New scene name: (ex: Tutorial, with capital)"
	@read NAME && sed "s/SCENE_NAME/$$NAME/g" $(template_dir)/scene.rb > `echo $(destination_dir)/scenes/$$NAME.rb | tr '[:upper:]' '[:lower:]'`
