# Ducky Engine

## How to use
1. Start with an empty DragonRuby app (find it [here](https://dragonruby.itch.io/dragonruby-gtk)).
2. Go to your game folder `cd mygame/app`
3. Clone Ducky Engine in your app

     git submodule add git@github.com:esilvert/ducky-engine.git ducky

  :warning: The folder containing the engine should be named `ducky`, not `ducky-engine`

4. Into the new `ducky` folder, you will find a Makefile to install it. Run:

    cd ducky && make install

## How to publish your game
### On Itch.io
Follow this [guide](http://docs.dragonruby.org.s3-website-us-east-1.amazonaws.com/#---creating-your-game-landing-page).

In short :
1. Create the game page on [itch.io](https://itch.io/game/new)
2. Update the game Metadata with
  - The `devid` property is the username you use to log into Itch.io
  - The `devtitle` is your name or company name (it can contain spaces).
  - The `gameid` is the Project URL value.
  - The `gametitle` is the name of your game (it can contain spaces).
  - The `version` can be any "major.minor" number format.
3. Run `./dragonruby-publish --only-package mygame`
   - (if you're on Windows, don't put the "./" on the front. That's a Mac and Linux thing.)
   - You can remove the `--only-package` to automatically upload on itch
