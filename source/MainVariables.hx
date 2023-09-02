package;

import lime.app.Application;
import openfl.display.BlendMode;
import haxe.Json;
import flixel.FlxG;
import openfl.filters.ColorMatrixFilter;
import openfl.filters.BitmapFilter;
import hxkv.Hxkv;

using StringTools;

typedef Variables =
{
	var resolution:Float;
	var fullscreen:Bool;
	var fps:Int;
	var mvolume:Int;
	var svolume:Int;
	var vvolume:Int;
	var scoreDisplay:Bool;
	var missesDisplay:Bool;
	var accuracyDisplay:Bool;
	var noteOffset:Int;
	var spamPrevention:Bool;
	var firstTime:Bool;
	var accuracyType:String;
	var ratingDisplay:Bool;
	var timingDisplay:Bool;
	var comboDisplay:Bool;
	var iconZoom:Float;
	var cameraZoom:Float;
	var cameraSpeed:Float;
	var filter:String;
	var brightness:Int;
	var gamma:Float;
	var muteMiss:Bool;
	var scroll:String;
	var songPosition:Bool;
	var nps:Bool;
	var fpsCounter:Bool;
	var comboP:Bool;
	var memory:Bool;
	var cutscene:Bool;
	var music:String;
	var watermark:Bool;
	var rainbow:Bool;
	var lateD:Bool;
	var sickX:Float;
	var sickY:Float;
	var guitarSustain:Bool;
	var fiveK:Bool;
	var speed:Float;
	var skipGO:Bool;
	var skipCS:Int;
	var comboH:Bool;
	var hue:Int;
	var distractions:Bool;
	var hitsound:String;
	var botplay:Bool;
	var hvolume:Int;
    var chromakey:Bool;
    var healthbarvis:Bool;
    var charactervis:Bool;
	var bgAlpha:Float;
	var enemyAlpha:Float;
	var autoPause:Bool;
	var pauseCountdown:Bool;
	var noteSplashes:Bool;
	var resetButton:Bool;
	var cheatButton:Bool;
	var noteGlow:Bool;
	var eNoteGlow:Bool;
	var missAnims:Bool;
	var hpColors:Bool;
	var hpIcons:Bool;
	var hpAnims:Bool;
	var iconStyle:String;
	var ghostTapping:Bool;
}

class MainVariables
{
	public static var _variables:Variables;

	public static var filters:Array<BitmapFilter> = [];

	public static var matrix:Array<Float>;
	public static var colorM:Array<Float>;

	public static var musicList:Array<String> = [];
	public static var hitList:Array<String> = [];
	public static var iconList:Array<String> = [];

	public static var configVersion:String = '2.0.3';
	public static var fileName:String = 'config-$configVersion';
	private static var _db:Hxkv = new Hxkv(fileName);

	public static function Save():Void
	{
		_db.set('main', Json.stringify(_variables));
	}

	// READING ASSETS DIRECTORY METHODS ARE EXPERIMENTAL AND I DO NOT KNOW IF THEY WORK PROPERLY
	public static function Load():Void
	{
		musicList = Paths.getLibraryFiles("default", "SOUND", "assets/music/menu");
		musicList = onlyNames(musicList);

		// probably not loaded, will move to preload if it crashes - had to preload shared too lol
		hitList = Paths.getLibraryFiles("shared", "SOUND", "assets/shared/sounds/hitsounds");
		hitList.unshift('assets/shared/sounds/hitsounds/none.ogg');
		hitList = onlyNames(hitList);

		// i only need the existing directories
		// dumbass parsing
		var bIconList:Array<String> = Paths.getLibraryFiles("shared", "IMAGE", "assets/shared/images/icons");
		var i:Int = 0;

		for (entry in bIconList)
		{
			var fixed:String = entry.replace("assets/shared/images/icons/", "");
			fixed = fixed.substring(0, fixed.lastIndexOf("/"));
			if (fixed.length <= 1)
				continue;

			if(iconList.indexOf(fixed) == -1)
				iconList[i] = fixed;
			else
				continue;

			i++;
		}

		if (_db.get("main") == null)
		{
			_variables = {
				resolution: 1,
				fullscreen: false,
				fps: 60,
				mvolume: 100,
				svolume: 100,
				vvolume: 100,
				scoreDisplay: true,
				missesDisplay: true,
				accuracyDisplay: true,
				noteOffset: 0,
				spamPrevention: false,
				firstTime: true,
				accuracyType: 'complex',
				ratingDisplay: true,
				timingDisplay: true,
				comboDisplay: true,
				iconZoom: 1,
				cameraZoom: 1,
				cameraSpeed: 1,
				filter: 'none',
				brightness: 0,
				gamma: 1,
				muteMiss: true,
				fpsCounter: true,
				songPosition: true,
				nps: true,
				comboP: true,
				memory: true,
				cutscene: true,
				music: "classic",
				watermark: true,
				rainbow: false,
				lateD: false,
				sickX: 650,
				sickY: 320,
				guitarSustain: false,
				fiveK: false,
				scroll: 'up',
				speed: 0,
				skipGO: false,
				skipCS: -1,
				comboH: false,
				hue: 0,
				distractions: true,
				hitsound: "none",
				botplay: false,
				hvolume: 100,
                chromakey: false,
                healthbarvis: false,
                charactervis: false,
				bgAlpha: 1,
				enemyAlpha: 0.3,
				autoPause: true,
				pauseCountdown: true,
				noteSplashes: true,
				resetButton: true,
				cheatButton: false,
				noteGlow: true,
				eNoteGlow: true,
				missAnims: true,
				hpColors: true,
				hpIcons: true,
				hpAnims: true,
				iconStyle: iconList[iconList.length - 1], // my guy would be getting null lmao
				ghostTapping: true
			};

			Save();
		}
		else
		{
			try
			{
				_variables = Json.parse(_db.get("main"));
			}
			catch (error)
			{
				var randomShit:String = "";
				if (FlxG.random.bool(50))
				{
					if (FlxG.random.bool(50))
						randomShit = "There was an error reading the config file.";
					else
						randomShit = "Skill issue.";
				}
				else
				{
					if (FlxG.random.bool(50))
						randomShit = "There were some troubles reading the config file.";
					else
						randomShit = "m8 u forgot something";
				}
				Application.current.window.alert(randomShit + '\nDETAILS: ' + error, 'Error');
			}
		}

		FlxG.resizeWindow(Math.round(FlxG.width * _variables.resolution), Math.round(FlxG.height * _variables.resolution));
		FlxG.fullscreen = _variables.fullscreen;
		FlxG.drawFramerate = _variables.fps;
		FlxG.updateFramerate = _variables.fps;
		Main.toggleFPS(_variables.fpsCounter);
		Main.toggleMem(_variables.memory);
		Main.watermark.visible = _variables.watermark;

		UpdateColors();
	}

	public static function UpdateColors():Void
	{
		filters = [];

		switch (_variables.filter)
		{
			case 'none':
				matrix = [
					1 * _variables.gamma,                    0,                    0, 0, _variables.brightness,
					                   0, 1 * _variables.gamma,                    0, 0, _variables.brightness,
					                   0,                    0, 1 * _variables.gamma, 0, _variables.brightness,
					                   0,                    0,                    0, 1,                     0,
				];
			case 'tritanopia':
				matrix = [
					0.20 * _variables.gamma, 0.99 * _variables.gamma, -.19 * _variables.gamma, 0, _variables.brightness,
					0.16 * _variables.gamma, 0.79 * _variables.gamma, 0.04 * _variables.gamma, 0, _variables.brightness,
					0.01 * _variables.gamma, -.01 * _variables.gamma,    1 * _variables.gamma, 0, _variables.brightness,
					                      0,                       0,                       0, 1,                     0,
				];
			case 'protanopia':
				matrix = [
					0.20 * _variables.gamma, 0.99 * _variables.gamma, -.19 * _variables.gamma, 0, _variables.brightness,
					0.16 * _variables.gamma, 0.79 * _variables.gamma, 0.04 * _variables.gamma, 0, _variables.brightness,
					0.01 * _variables.gamma, -.01 * _variables.gamma,    1 * _variables.gamma, 0, _variables.brightness,
					                      0,                       0,                       0, 1,                     0,
				];
			case 'deutranopia':
				matrix = [
					0.43 * _variables.gamma, 0.72 * _variables.gamma, -.15 * _variables.gamma, 0, _variables.brightness,
					0.34 * _variables.gamma, 0.57 * _variables.gamma, 0.09 * _variables.gamma, 0, _variables.brightness,
					-.02 * _variables.gamma, 0.03 * _variables.gamma,    1 * _variables.gamma, 0, _variables.brightness,
					                      0,                       0,                       0, 1,                     0,
				];
			case 'virtual boy':
				matrix = [
					0.9 * _variables.gamma, 0, 0, 0, _variables.brightness,
					                     0, 0, 0, 0,                     0,
					                     0, 0, 0, 0,                     0,
					                     0, 0, 0, 1,                     0,
				];
			case 'gameboy':
				matrix = [
					0,                      0, 0, 0,                     0,
					0, 1.5 * _variables.gamma, 0, 0, _variables.brightness,
					0,                      0, 0, 0,                     0,
					0,                      0, 0, 1,                     0,
				];
			case 'downer':
				matrix = [
					0, 0,                      0, 0,                     0,
					0, 0,                      0, 0,                     0,
					0, 0, 1.5 * _variables.gamma, 0, _variables.brightness,
					0, 0,                      0, 1,                     0,
				];
			case 'grayscale':
				matrix = [
					.3 * _variables.gamma, .3 * _variables.gamma, .3 * _variables.gamma, 0, _variables.brightness,
					.3 * _variables.gamma, .3 * _variables.gamma, .3 * _variables.gamma, 0, _variables.brightness,
					.3 * _variables.gamma, .3 * _variables.gamma, .3 * _variables.gamma, 0, _variables.brightness,
					                    0,                     0,                     0, 1,                     0,
				];
			case 'invert':
				matrix = [
					-1 * _variables.gamma,                     0,                     0, 0, 255 + _variables.brightness,
					                    0, -1 * _variables.gamma,                     0, 0, 255 + _variables.brightness,
					                    0,                     0, -1 * _variables.gamma, 0, 255 + _variables.brightness,
					                    0,                     0,                     0, 1,                           1,
				];
		}

		filters.push(new ColorMatrixFilter(matrix));
		UpdateHue();
		FlxG.game.filtersEnabled = true;
		FlxG.game.setFilters(filters);
	}

	public static function UpdateHue():Void
	{
		var cosA:Float = Math.cos(-_variables.hue * Math.PI / 180);
		var sinA:Float = Math.sin(-_variables.hue * Math.PI / 180);

		var a1:Float = cosA + (1.0 - cosA) / 3.0;
		var a2:Float = 1.0 / 3.0 * (1.0 - cosA) - Math.sqrt(1.0 / 3.0) * sinA;
		var a3:Float = 1.0 / 3.0 * (1.0 - cosA) + Math.sqrt(1.0 / 3.0) * sinA;

		var b1:Float = a3;
		var b2:Float = cosA + 1.0 / 3.0 * (1.0 - cosA);
		var b3:Float = a2;

		var c1:Float = a2;
		var c2:Float = a3;
		var c3:Float = b2;

		colorM = [
			a1, b1, c1, 0, 0,
			a2, b2, c2, 0, 0,
			a3, b3, c3, 0, 0,
			 0,  0,  0, 1, 0
		];

		filters.push(new ColorMatrixFilter(colorM));
	}

	private static function onlyNames(array:Array<String>):Array<String>
	{
		// copy for safety purposes
		var copy:Array<String> = array;
		for(entry in array)
		{
			copy[array.indexOf(entry)] = haxe.io.Path.withoutExtension(haxe.io.Path.withoutDirectory(entry));
		}

		return copy;
	}
}
