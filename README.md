# Funkin Mic'D UP ported to HTML5 with all of the features working

currently the engine is a massive ram eater so be aware of it

more professional readme coming once i finish all of the shit

hear me out i had trouble cooking all of this like the code was just too much i dont even know how i managed to do it

og readme in README_copy

if i manage to make it fully html5 compatible might move some feature to [my engine](https://github.com/SanicBTW/Just-Another-FNF-Engine) (pls go check it out)

and if it gets enough attention i might give the following:
- extended support
- flixel 5 support
- optimizations
- cleaner code

or instead you can do a fork and add these by yourself since all of the breaking stuff for html5 has been addressed already so you can modify anything and it wont break that easily i guess

Changes:
- most of the parts that require text files manipulation are now managed by [hxkv](https://github.com/yourfriendoss/Hxkv/tree/main) (as a cross platform alternative for JSON management), default FlxSave store for basic text files
- controls may conflict with each other, i will probably use [my controls](https://github.com/SanicBTW/Just-Another-FNF-Engine/blob/master/source/backend/Controls.hx) if its really annoying
- i had to write more here but i literally forgot everything that i had to sooo yeah

TODO:
- make MainVariables support just like ModifierVariables (DONE)
- GFX page crashes (FIXED)
- settings seems to not save (FIXED - somehow)
- controls not saving (FIXED - instead of using FlxSave it uses the MainVariables database)

- add marathon presets saving (substate, menu)
- add survival presets saving (substate, game options, menu)
- add endless presets saving (substate and menu)
- when wanting to save content on some debug states, copy the text to the user clipboard and notify about it
- some shit on substate preset save ok dunno
- actual video support from the amazing fps plus prob i aint gonna snatch the psych support
- better asset support (more libraries for better management)
- song not loading when the library is cached??
- blueballed count
- explosive audio when changing keybinds

LIBS NEEDED:
- actuate: 1.9.0
- flixel-addons: 2.11.0
- flixel-ui: 2.5.0
- flixel: 4.11.0
- hscript-plus: haxelib git hscript-plus https://github.com/DleanJeans/hscript-plus
- hscript: [2.4.0] 2.5.0 (didnt test it out but downgraded it cuz of polymod)
- hxcpp: 4.3.2
- hxkv: 2.0.1
- lime-samples: 7.0.0
- lime: 7.9.0
- openfl: 9.1.0
- polymod: 1.3.1
- random: 1.4.1
- seedyrng: 1.1.0
- systools: 1.1.0
- thx.semver: 0.2.2