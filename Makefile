install_dir = install_files
target_dir = ../mygame/app

install: directories
	cp $(install_dir)/main.rb $(target_dir)
	cp $(install_dir)/repl.rb $(target_dir)
	cp $(install_dir)/lib.rb $(target_dir)
	cp $(install_dir)/models.rb $(target_dir)
	cp $(install_dir)/scenes.rb $(target_dir)
	cp $(install_dir)/main_menu.rb $(target_dir)/scenes/
	cp $(install_dir)/game.rb $(target_dir)
	cp $(install_dir)/Makefile ../

directories:
	[ -d $(target_dir)/models ] || mkdir $(target_dir)/models
	[ -d $(target_dir)/scenes ] || mkdir $(target_dir)/scenes
