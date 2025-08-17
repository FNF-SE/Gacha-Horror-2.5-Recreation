package objects;

import backend.animation.PsychAnimationController;
import flixel.util.FlxSort;
import flixel.util.FlxDestroyUtil;
import openfl.utils.AssetType;
import openfl.utils.Assets;
import backend.Song;
import backend.Section;

typedef CharacterFile =
{
	var animations:Array<AnimArray>;
	var image:flixel.util.typeLimit.OneOfTwo<String, Array<String>>;
	var scale:Float;
	var sing_duration:Float;
	var healthicon:String;

	var position:Array<Float>;
	var camera_position:Array<Float>;

	var flip_x:Bool;
	var no_antialiasing:Bool;
	var healthbar_colors:Array<Int>;
	var vocals_file:String;
	@:optional var _editor_isPlayer:Null<Bool>;
}

typedef AnimArray =
{
	var anim:String;
	var name:String;
	var fps:Int;
	var loop:Bool;
	var indices:Array<Int>;
	var offsets:Array<Int>;
}

class Character extends FlxSprite
{
	/**
	 * In case a character is missing, it will use this on its place
	**/
	public static final DEFAULT_CHARACTER:String = 'bf';

	public var animOffsets:Map<String, Array<Dynamic>>;
	public var debugMode:Bool = false;
	public var extraData:Map<String, Dynamic> = new Map<String, Dynamic>();

	public var isPlayer:Bool = false;
	public var curCharacter:String = DEFAULT_CHARACTER;

	public var holdTimer:Float = 0;
	public var heyTimer:Float = 0;
	public var specialAnim:Bool = false;
	public var animationNotes:Array<Dynamic> = [];
	public var stunned:Bool = false;
	public var singDuration:Float = 4; // Multiplier of how long a character holds the sing pose
	public var idleSuffix:String = '';
	public var danceIdle:Bool = false; // Character use "danceLeft" and "danceRight" instead of "idle"
	public var skipDance:Bool = false;

	public var healthIcon:String = 'face';
	public var animationsArray:Array<AnimArray> = [];

	public var positionArray:Array<Float> = [0, 0];
	public var cameraPosition:Array<Float> = [0, 0];
	public var healthColorArray:Array<Int> = [255, 0, 0];

	public var hasMissAnimations:Bool = false;
	public var vocalsFile:String = '';

	// Used on Character Editor
	public var imageFile:String = '';
	public var jsonScale:Float = 1;
	public var noAntialiasing:Bool = false;
	public var originalFlipX:Bool = false;
	public var editorIsPlayer:Null<Bool> = null;

	public var isMultiAtlas:Bool = false;

	// ghosties
	public var allowGhost:Bool = true;
	public var prevRow:Int = -1;
	public var ghostMovement:Bool = false;
	public var ghostDistance:Float = 50;
	public var ghostSprites:Array<FlxSprite> = [];
	public var ghostTweens:Array<FlxTween> = [];

	public function new(x:Float, y:Float, ?character:String = 'bf', ?isPlayer:Bool = false)
	{
		super(x, y);

		animation = new PsychAnimationController(this);

		animOffsets = new Map<String, Array<Dynamic>>();
		curCharacter = character;
		this.isPlayer = isPlayer;
		changeCharacter(character);

		// key amount
		for(i in 0...4)
		{
			var ghost:FlxSprite = new FlxSprite();
			ghost.alpha = 0;
			ghostSprites.push(ghost);
		}
	}

	public function changeCharacter(character:String)
	{
		animationsArray = [];
		animOffsets = [];
		curCharacter = character;
		var characterPath:String = 'characters/$character.json';

		var path:String = Paths.getPath(characterPath, TEXT);
		#if MODS_ALLOWED
		if (!FileSystem.exists(path))
		#else
		if (!Assets.exists(path))
		#end
		{
			path = Paths.getSharedPath('characters/' + DEFAULT_CHARACTER +
				'.json'); // If a character couldn't be found, change him to BF just to prevent a crash
			color = FlxColor.BLACK;
			alpha = 0.6;
		}

		try
		{
			#if MODS_ALLOWED
			loadCharacterFile(haxe.Json.parse(File.getContent(path)));
			#else
			loadCharacterFile(haxe.Json.parse(Assets.getText(path)));
			#end
		}
		catch(e:Dynamic)
		{
			trace('Error loading character file of "$character": $e');
		}

		skipDance = false;
		hasMissAnimations = hasAnimation('singLEFTmiss') || hasAnimation('singDOWNmiss') || hasAnimation('singUPmiss') || hasAnimation('singRIGHTmiss');
		recalculateDanceIdle();
		dance();
	}

	override public function isOnScreen(?camera:FlxCamera):Bool
	{
		if (isMultiAtlas)
			return true; // flixel is stoobid

		if (camera == null)
			camera = FlxG.camera;

		return camera.containsRect(getScreenBounds(_rect, camera));
	}

	public function loadCharacterFile(json:Dynamic)
	{
		scale.set(1, 1);
		updateHitbox();
		isMultiAtlas = !(json.image is String);

		if (isMultiAtlas) // idk if ghosts can work with this or not
		{
			frames = Paths.getAtlas(json.image[0]);
			final split:Array<String> = json.image;
			if (frames != null)
			for (imgFile in split)
			{
				final daAtlas = Paths.getAtlas(imgFile);
				if (daAtlas != null)
					cast(frames, flixel.graphics.frames.FlxAtlasFrames).addAtlas(daAtlas);
			}
			imageFile = json.image[0];
		}
		else
		{
			frames = Paths.getAtlas(json.image);
			imageFile = json.image;
		}

		jsonScale = json.scale;
		if (json.scale != 1)
		{
			scale.set(jsonScale, jsonScale);
			updateHitbox();
		}

		// positioning
		positionArray = json.position;
		cameraPosition = json.camera_position;

		// data
		healthIcon = json.healthicon;
		singDuration = json.sing_duration;
		flipX = (json.flip_x != isPlayer);
		healthColorArray = (json.healthbar_colors != null && json.healthbar_colors.length > 2) ? json.healthbar_colors : [161, 161, 161];
		vocalsFile = json.vocals_file != null ? json.vocals_file : '';
		originalFlipX = (json.flip_x == true);
		editorIsPlayer = json._editor_isPlayer;

		// antialiasing
		noAntialiasing = (json.no_antialiasing == true);
		antialiasing = ClientPrefs.data.antialiasing ? !noAntialiasing : false;

		// animations
		animationsArray = json.animations;
		if (animationsArray != null && animationsArray.length > 0)
		{
			for (anim in animationsArray)
			{
				var animAnim:String = '' + anim.anim;
				var animName:String = '' + anim.name;
				var animFps:Int = anim.fps;
				var animLoop:Bool = !!anim.loop; // Bruh
				var animIndices:Array<Int> = anim.indices;

				if (animIndices != null && animIndices.length > 0)
					animation.addByIndices(animAnim, animName, animIndices, "", animFps, animLoop);
				else
					animation.addByPrefix(animAnim, animName, animFps, animLoop);

				if (anim.offsets != null && anim.offsets.length > 1)
					addOffset(anim.anim, anim.offsets[0], anim.offsets[1]);
				else
					addOffset(anim.anim, 0, 0);
			}
		}
		// trace('Loaded file to character ' + curCharacter);
	}

	override function update(elapsed:Float)
	{
		if (debugMode || animation.curAnim == null)
		{
			super.update(elapsed);
			return;
		}

		if (heyTimer > 0)
		{
			var rate:Float = (PlayState.instance != null ? PlayState.instance.playbackRate : 1.0);
			heyTimer -= elapsed * rate;
			if (heyTimer <= 0)
			{
				var anim:String = getAnimationName();
				if (specialAnim && (anim == 'hey' || anim == 'cheer'))
				{
					specialAnim = false;
					dance();
				}
				heyTimer = 0;
			}
		}
		else if (specialAnim && isAnimationFinished())
		{
			specialAnim = false;
			dance();
		}
		else if (getAnimationName().endsWith('miss') && isAnimationFinished())
		{
			dance();
			finishAnimation();
		}

		if (getAnimationName().startsWith('sing'))
			holdTimer += elapsed;
		else if (isPlayer)
			holdTimer = 0;

		if (!isPlayer
			&& holdTimer >= Conductor.stepCrochet * (0.0011 #if FLX_PITCH / (FlxG.sound.music != null ? FlxG.sound.music.pitch : 1) #end) * singDuration)
		{
			dance();
			holdTimer = 0;
		}

		var name:String = getAnimationName();
		if (isAnimationFinished() && hasAnimation('$name-loop'))
			playAnim('$name-loop');

		for(ghost in ghostSprites)
		{
			ghost?.update(elapsed);
		}

		super.update(elapsed);
	}

	inline public function isAnimationNull():Bool
		return (animation.curAnim == null);

	inline public function getAnimationName():String
	{
		var name:String = '';
		@:privateAccess
		if (!isAnimationNull())
			name = animation.curAnim.name;
		return (name != null) ? name : '';
	}

	public function isAnimationFinished():Bool
	{
		if (isAnimationNull())
			return false;
		return animation.curAnim.finished;
	}

	public function finishAnimation():Void
	{
		if (isAnimationNull())
			return;

		animation.curAnim.finish();
	}

	public function hasAnimation(anim:String):Bool
	{
		return animOffsets.exists(anim);
	}

	public var animPaused(get, set):Bool;

	private function get_animPaused():Bool
	{
		if (isAnimationNull())
			return false;
		return animation.curAnim.paused;
	}

	private function set_animPaused(value:Bool):Bool
	{
		if (isAnimationNull())
			return value;

		animation.curAnim.paused = value;

		return value;
	}

	public var danced:Bool = false;

	/**
	 * Plays the characters idle animation
	 */
	public function dance()
	{
		if (!debugMode && !skipDance && !specialAnim)
		{
			if (danceIdle)
			{
				danced = !danced;

				if (danced)
					playAnim('danceRight' + idleSuffix);
				else
					playAnim('danceLeft' + idleSuffix);
			}
			else if (hasAnimation('idle' + idleSuffix))
			{
				playAnim('idle' + idleSuffix);
			}
		}
	}

	public function playAnim(AnimName:String, Force:Bool = false, Reversed:Bool = false, Frame:Int = 0):Void
	{
		specialAnim = false;
		animation.play(AnimName, Force, Reversed, Frame);

		if (hasAnimation(AnimName))
		{
			var daOffset = animOffsets.get(AnimName);
			offset.set(daOffset[0], daOffset[1]);
		}
		// else offset.set(0, 0);

		if (curCharacter.startsWith('gf-') || curCharacter == 'gf')
		{
			if (AnimName == 'singLEFT')
				danced = true;
			else if (AnimName == 'singRIGHT')
				danced = false;

			if (AnimName == 'singUP' || AnimName == 'singDOWN')
				danced = !danced;
		}
	}

	public function playGhostAnim(GhostNum:Int, AnimName:String, Force:Bool = false, Reversed:Bool = false, Frame:Int = 0):Void
	{
		// trace(GhostNum);
		if(!allowGhost /* || ghostSprites[GhostNum] == null*/) return;

		if(AnimName.endsWith('alt') && animation.getByName(AnimName) == null)
			AnimName = AnimName.split('-')[0];

		if(ghostTweens[GhostNum] != null)
			ghostTweens[GhostNum].cancel();

		var ghost:FlxSprite = ghostSprites[GhostNum];
		ghost.frames = frames;
		ghost.animation.copyFrom(animation);
		ghost.scale.copyFrom(scale);
		ghost.updateHitbox();
		ghost.antialiasing = antialiasing;
		ghost.x = x;
		ghost.y = y;
		ghost.flipX = flipX;
		ghost.flipY = flipY;
		ghost.angle = angle;
		ghost.alpha = alpha * 0.8;
		ghost.visible = visible;
		if (!PlayState.instance.inSilhouette)
			ghost.color = color;
		else
			ghost.color = FlxColor.BLACK;

		ghost.animation.play(AnimName, Force, Reversed, Frame);
		if(hasAnimation(AnimName))
		{
			final daOffset = animOffsets.get(AnimName);
			ghost.offset.set(daOffset[0], daOffset[1]);
		}
		var moveOffset:Array<Float> = [0, 0];
		if (ghostMovement)
		{
			if (AnimName.startsWith('singLEFT')) moveOffset[0] = -ghostDistance;
			else if (AnimName.startsWith('singRIGHT')) moveOffset[0] = ghostDistance;
			else if (AnimName.startsWith('singUP')) moveOffset[1] = -ghostDistance;
			else if (AnimName.startsWith('singDOWN')) moveOffset[1] = ghostDistance;
		}

		ghostTweens[GhostNum] = FlxTween.tween(ghost, {x: ghost.x + moveOffset[0], y: ghost.y + moveOffset[1], alpha: 0}, 0.7,
		{
			ease: FlxEase.quartOut, // linear was BORING    - DM
			onComplete: function(no:FlxTween)
			{
				ghost.alpha = 0;
				ghostTweens[GhostNum] = null;
			}
		});
	}

	function loadMappedAnims():Void
	{
		try
		{
			var noteData:Array<SwagSection> = Song.loadFromJson('picospeaker', Paths.formatToSongPath(PlayState.SONG.song)).notes;
			for (section in noteData)
			{
				for (songNotes in section.sectionNotes)
				{
					animationNotes.push(songNotes);
				}
			}
			animationNotes.sort(sortAnims);
		}
		catch (e:Dynamic)
		{
		}
	}

	function sortAnims(Obj1:Array<Dynamic>, Obj2:Array<Dynamic>):Int
	{
		return FlxSort.byValues(FlxSort.ASCENDING, Obj1[0], Obj2[0]);
	}

	public var danceEveryNumBeats:Int = 2;

	private var settingCharacterUp:Bool = true;

	public function recalculateDanceIdle()
	{
		var lastDanceIdle:Bool = danceIdle;
		danceIdle = (hasAnimation('danceLeft' + idleSuffix) && hasAnimation('danceRight' + idleSuffix));

		if (settingCharacterUp)
		{
			danceEveryNumBeats = (danceIdle ? 1 : 2);
		}
		else if (lastDanceIdle != danceIdle)
		{
			var calc:Float = danceEveryNumBeats;
			if (danceIdle)
				calc /= 2;
			else
				calc *= 2;

			danceEveryNumBeats = Math.round(Math.max(calc, 1));
		}
		settingCharacterUp = false;
	}

	public function addOffset(name:String, x:Float = 0, y:Float = 0)
	{
		animOffsets[name] = [x, y];
	}

	public function quickAnimAdd(name:String, anim:String)
	{
		animation.addByPrefix(name, anim, 24, false);
	}
	/*
	public function copyGhostValues()
	{
		if(ghost == null) return;
		@:privateAccess
		{
			ghost.cameras = cameras;
			ghost.scrollFactor = scrollFactor;
			ghost.scale = scale;
			ghost.origin = origin;
			ghost.x = x;
			ghost.y = y;
			ghost.angle = angle;
			ghost.visible = visible;
			ghost.flipX = flipX;
			ghost.flipY = flipY;
		}
	}
	*/
	override function draw()
	{
		for (ghost in ghostSprites)
		{
			if (ghost.visible && ghost.alpha != 0) ghost.draw();
		}
		super.draw();
	}
	public override function destroy()
	{
		for(ghost in ghostSprites) ghost = FlxDestroyUtil.destroy(ghost);
		super.destroy();
	}
}
