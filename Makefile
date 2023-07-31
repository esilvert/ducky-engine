install: directories
	cp install_files/main.rb ../mygame/app/
	cp install_files/repl.rb ../mygame/app/
	cp install_files/lib.rb ../mygame/app/
	cp install_files/models.rb ../mygame/app/
	cp install_files/scenes.rb ../mygame/app/
	cp install_files/main_menu.rb ../mygame/app/scenes/
	cp install_files/game.rb ../mygame/app/
	cp install_files/Makefile ../

directories:
	[ -d ../mygame/app/models ] || mkdir ../mygame/app/models
	[ -d ../mygame/app/scenes ] || mkdir ../mygame/app/scenes
