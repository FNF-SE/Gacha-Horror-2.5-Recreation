package;

import debug.codename.Framerate;
import flixel.graphics.FlxGraphic;
import flixel.FlxGame;
import flixel.FlxState;
import haxe.io.Path;
import openfl.Assets;
import openfl.system.System;
import openfl.Lib;
import openfl.display.Sprite;
import openfl.events.Event;
import openfl.display.StageScaleMode;
import lime.system.System as LimeSystem;
import lime.app.Application;
import states.TitleState;
import openfl.events.KeyboardEvent;
#if (linux || mac)
import lime.graphics.Image;
#end

#if (linux && !debug)
@:cppInclude('./external/gamemode_client.h')
@:cppFileCode('#define GAMEMODE_AUTO')
#end
class Main extends Sprite
{
	public static final game = {
		width: 1280, // WINDOW width
		height: 720, // WINDOW height
		initialState: TitleState, // initial game state
		zoom: -1.0, // game state bounds
		framerate: 60, // default framerate
		skipSplash: true, // if the default flixel splash screen should be skipped
		startFullscreen: false // if the game should start at fullscreen mode
	};

	public static var fpsVar:Framerate;

	#if mobile
	public static final platform:String = "Phones";
	#else
	public static final platform:String = "PCs";
	#end

	// You can pretty much ignore everything from here on - your code should go in your states.

	public static function main():Void
	{
		Lib.current.addChild(new Main());
		#if cpp
		cpp.NativeGc.enable(true);
		#elseif hl
		hl.Gc.enable(true);
		#end
	}

	public function new()
	{
		backend.CrashHandler.init();
		#if mobile
		Sys.setCwd(StorageUtil.getStorageDirectory());
		#if android
		StorageUtil.requestPermissions();
		#end
		#end
		super();

		#if (cpp && windows)
		backend.Native.fixScaling();
		backend.Native.setDarkMode(true);
		#end

		trace(openfl.system.Capabilities.version);

		if (stage != null)
		{
			init();
		}
		else
		{
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
	}

	private function init(?E:Event):Void
	{
		if (hasEventListener(Event.ADDED_TO_STAGE))
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
		}

		setupGame();
	}

	private function setupGame():Void
	{
		if (game.zoom == -1.0)
			game.zoom = 1.0;

		#if LUA_ALLOWED Lua.set_callbacks_function(cpp.Callable.fromStaticFunction(psychlua.CallbackHandler.call)); #end
		Controls.instance = new Controls();
		ClientPrefs.loadDefaultKeys();

		final funkinGame:FlxGame = new FlxGame(game.width, game.height, game.initialState, #if (flixel < "5.0.0") game.zoom, #end game.framerate,
			game.framerate, game.skipSplash, game.startFullscreen);

		@:privateAccess
		{
			final soundFrontEnd:flixel.system.frontEnds.SoundFrontEnd = new objects.CustomSoundTray.CustomSoundFrontEnd();
			FlxG.sound = soundFrontEnd;
			funkinGame._customSoundTray = objects.CustomSoundTray.CustomSoundTray;
		}

		addChild(funkinGame);

		addChild(fpsVar = new Framerate());
		debug.codename.SystemInfo.init();

		Lib.current.stage.align = "tl";
		Lib.current.stage.scaleMode = StageScaleMode.NO_SCALE;
		#if mobile
		//FlxG.game.stage.quality = openfl.display.StageQuality.LOW;
		#end
		if (fpsVar != null)
			fpsVar.visible = ClientPrefs.data.showFPS;

		#if (linux || mac)
		final icon:Image = Image.fromFile("icon.png");
		Lib.current.stage.window.setIcon(icon);
		#end

		#if desktop
		FlxG.stage.addEventListener(KeyboardEvent.KEY_UP, toggleFullScreen);
		#end

		#if DISCORD_ALLOWED
		DiscordClient.prepare();
		#end

		#if mobile
		LimeSystem.allowScreenTimeout = ClientPrefs.data.screensaver;
		#end

		#if android
		FlxG.android.preventDefaultKeys = [BACK];
		#end

		Application.current.window.vsync = ClientPrefs.data.vsync;

		// shader coords fix
		FlxG.signals.gameResized.add(function(w, h)
		{
			#if mobile
			if (fpsVar != null)
				fpsVar.setScale(Math.min(Lib.current.stage.stageWidth / FlxG.width, Lib.current.stage.stageHeight / FlxG.height));
			#end

			if (FlxG.cameras != null)
			{
				for (cam in FlxG.cameras.list)
				{
					if (cam != null && cam.filters != null)
						resetSpriteCache(cam.flashSprite);
				}
			}

			if (FlxG.game != null)
				resetSpriteCache(FlxG.game);
		});
	}

	static function resetSpriteCache(sprite:Sprite):Void
	{
		@:privateAccess {
			sprite.__cacheBitmap = null;
			sprite.__cacheBitmapData = null;
		}
	}

	function toggleFullScreen(event:KeyboardEvent):Void
	{
		if (Controls.instance.justReleased('fullscreen'))
			FlxG.fullscreen = !FlxG.fullscreen;
	}
}
