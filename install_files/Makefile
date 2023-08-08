template_dir = ducky/templates
destination_dir = mygame/app/scenes

run_game:
	./dragonruby

update_ducky:
	cd ducky && git pull && make install && cd -

clear_logs:
	rm -r logs/

new_scene:
	@echo "New scene name: (ex: Tutorial, with capital)"
	@read NAME && sed "s/SCENE_NAME/$$NAME/Ig" $(template_dir)/scene.rb > `echo $(destination_dir)/$$NAME.rb | tr '[:upper:]' '[:lower:]'`
