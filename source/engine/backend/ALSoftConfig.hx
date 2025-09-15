package backend;

#if (desktop || mobile)
import lime.system.System;
import haxe.macro.Context;
import haxe.macro.Expr;
import haxe.io.Path;
#if android
import lime.system.JNI;
#end
#if sys
import sys.io.File;
import sys.FileSystem;
#end

/**
 * A class that simply points OpenALSoft to a custom configuration file when the game starts up.
 * The config overrides a few global OpenALSoft settings with the aim of improving audio quality on desktop targets.
 */
#if !macro
@:build(backend.ALSoftConfig.setupConfig())
#end
class ALSoftConfig
{
	#if (desktop || mobile)
	private static final OPENAL_CONFIG:String = '';

	public static function init():Void
	{
		final configPath:String = Path.join([
			#if mobile Path.directory(Path.withoutExtension(System.applicationStorageDirectory)) #elseif mac Path.directory(Path.withoutExtension(Sys.programPath())) +
			'/Resources/' #else Sys.getCwd() #end,
			#if windows 'alsoft.ini' #else 'alsoft.conf' #end
		]);
		if (!FileSystem.exists(Path.directory(configPath)))
			FileSystem.createDirectory(Path.directory(configPath));
		File.saveContent(configPath, OPENAL_CONFIG);
		#if android
		JNI.createStaticMethod('org/libsdl/app/SDLActivity', 'nativeSetenv', '(Ljava/lang/String;Ljava/lang/String;)V')("ALSOFT_CONF", configPath);
		#else
		Sys.putEnv("ALSOFT_CONF", configPath);
		#end
	}
	#end

	#if macro
	public static function setupConfig()
	{
		var fields = Context.getBuildFields();
		var pos = Context.currentPos();

		if (!FileSystem.exists('alsoft.txt'))
			return fields;

		var newFields = fields.copy();
		for (i => field in fields)
		{
			if (field.name == 'OPENAL_CONFIG')
			{
				newFields[i] = {
					name: 'OPENAL_CONFIG',
					access: [APrivate, AStatic, AFinal],
					kind: FVar(macro :String, macro $v{File.getContent('alsoft.txt')}),
					pos: pos,
				};
			}
		}

		return newFields;
	}
	#end
}
#end