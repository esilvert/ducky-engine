install:
	cp install_files/main.rb ../mygame/app/main.rb
	cp install_files/repl.rb ../mygame/app/repl.rb
	cp install_files/lib.rb ../mygame/app/lib.rb
	cp install_files/models.rb ../mygame/app/models.rb
	cp install_files/scenes.rb ../mygame/app/scenes.rb
	cp install_files/Makefile ../Makefile
	mkdir ../mygame/app/{models,scenes}
