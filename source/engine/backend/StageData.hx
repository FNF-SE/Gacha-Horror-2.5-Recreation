package backend;

import openfl.utils.Assets;
import backend.Song;

typedef StageFile =
{
	var directory:String;
	var defaultZoom:Float;
	var isPixelStage:Bool;
	var stageUI:String;

	var boyfriend:Array<Dynamic>;
	var girlfriend:Array<Dynamic>;
	var opponent:Array<Dynamic>;
	var hide_girlfriend:Bool;

	var camera_boyfriend:Array<Float>;
	var camera_opponent:Array<Float>;
	var camera_girlfriend:Array<Float>;
	var camera_speed:Null<Float>;

	@:optional var preload:Dynamic;
}

class StageData
{
	public static function dummy():StageFile
	{
		return {
			directory: "",
			defaultZoom: 0.9,
			isPixelStage: false,
			stageUI: "normal",

			boyfriend: [770, 100],
			girlfriend: [400, 130],
			opponent: [100, 100],
			hide_girlfriend: false,

			camera_boyfriend: [0, 0],
			camera_opponent: [0, 0],
			camera_girlfriend: [0, 0],
			camera_speed: 1
		};
	}

	public static var forceNextDirectory:String = null;

	public static function loadDirectory(SONG:SwagSong)
	{
		var stage:String = '';
		if (SONG.stage != null)
		{
			stage = SONG.stage;
		}
		else if (SONG.song != null)
		{
			switch (SONG.song.toLowerCase().replace(' ', '-'))
			{
				default:
					stage = 'stage';
			}
		}
		else
		{
			stage = 'stage';
		}

		var stageFile:StageFile = getStageFile(stage);
		if (stageFile == null)
		{ // preventing crashes
			forceNextDirectory = '';
		}
		else
		{
			forceNextDirectory = stageFile.directory;
		}
	}

	public static function getStageFile(stage:String):StageFile
	{
		var rawJson:String = null;
		var path:String = Paths.getSharedPath('stages/' + stage + '.json');

		#if MODS_ALLOWED
		var modPath:String = Paths.modFolders('stages/' + stage + '.json');
		if (FileSystem.exists(modPath))
		{
			rawJson = File.getContent(modPath);
		}
		else if (FileSystem.exists(path))
		{
			rawJson = File.getContent(path);
		}
		#else
		if (Assets.exists(path))
		{
			rawJson = Assets.getText(path);
		}
		#end
	else
	{
		return null;
	}
		return cast haxe.Json.parse(rawJson);
	}

	public static function vanillaSongStage(songName):String
	{
		return 'Gachastage';
	}
}
