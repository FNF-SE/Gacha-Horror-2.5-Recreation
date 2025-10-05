package objects;

import backend.CoolUtil;
import states.PlayState;
import objects.HUDImpl.ScoreUpdateTypes;
import flixel.text.FlxText;
import flixel.util.FlxStringUtil;

class GHRHUD extends BaseHUD
{
	public final TEXT_FONT:String = Paths.font("Comfortaa-Bold.ttf");

	public var topBar:FlxSprite;
	public var scoreBar:FlxSprite;
	public var accuracyBar:FlxSprite;
	public var songBar:FlxSprite;

	public var scoreText:FlxText;
	public var missesText:FlxText;
	public var accuracyText:FlxText;
	public var timeText:FlxText;
	public var songText:FlxText;

	public var bfColors:Array<Int> = [97, 217, 179];
	public var dadColors:Array<Int> = [80, 90, 143];

	private var playState:PlayState;
	private var isDownscroll:Bool;
	private var playingAsDad:Bool;
	private var cachedTime:Int = 0;

	private var evil = false;

	private var singleDad = false;
	private var singleBf = false;

	public function new(playState:PlayState)
	{
		super();

		this.playState = playState;
		scoreUpdateType = ScoreUpdateTypes.SEPERATE;

		isDownscroll = ClientPrefs.data.downScroll;
		playingAsDad = (playState.characterPlayingAsDad || PlayState.SONG.song == "Gates Of Hell");

		fields.set('topBar', add(topBar = new FlxSprite(345, isDownscroll ? -20 : 640).loadGraphic(Paths.image("hudassets/topBar"))));
		fields.set('scoreBar', add(scoreBar = new FlxSprite(176, isDownscroll ? 0 : 643).loadGraphic(Paths.image("hudassets/bar"))));
		fields.set('accuracyBar', add(accuracyBar = new FlxSprite(0, isDownscroll ? 0 : 643).loadGraphic(Paths.image("hudassets/bar"))));
		fields.set('songBar', add(songBar = new FlxSprite(973, isDownscroll ? 0 : 671).loadGraphic(Paths.image("hudassets/songName"))));

		topBar.flipY = !isDownscroll;

		fields.set('scoreText', cast(add(scoreText = new FlxText(162, isDownscroll ? 20 : 665, 180, "S: ?")), FlxText));
		fields.set('missesText', cast(add(missesText = new FlxText(326, isDownscroll ? 18 : 662, 200, "X: ?")), FlxText));
		fields.set('accuracyText', cast(add(accuracyText = new FlxText(-12, isDownscroll ? 20 : 665, 180, "A: N/A")), FlxText));
		fields.set('timeText', cast(add(timeText = new FlxText(714, isDownscroll ? 18 : 662, 205, " ")), FlxText));
		fields.set('songText', cast(add(songText = new FlxText(518, isDownscroll ? 5 : 676, 1235, PlayState.SONG.song)), FlxText));

		final textFields:Array<FlxText> = [scoreText, missesText, accuracyText, timeText, songText];
		final sizes:Array<Int> = [30, 30, 30, 34, 36];

		for (i => text in textFields)
		{
			text.setFormat(TEXT_FONT, sizes[i], FlxColor.WHITE, CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
			text.scrollFactor.set();
			text.borderSize = 2;
		}

		playState.healthBar.x -= 18;
		playState.healthBar.bg.x -= 18;
		playState.healthBar.y += isDownscroll ? -28 : 13;
		playState.healthBar.bg.y += isDownscroll ? -28 : 13;
		playState.healthBar.flipX = playingAsDad;

		if (PlayState.SONG.song != "Gates Of Hell")
			playState.iconP1.flipX = playingAsDad;

		if (PlayState.SONG.song == "Crisis" || PlayState.SONG.song == "Sentient")
			singleDad = true;

		this.cameras = [playState.camHUD];
	}

	override public function createPost():Void
	{
		playState.dad.healthColorArray = dadColors.copy();
		playState.boyfriend.healthColorArray = bfColors.copy();
		playState.reloadHealthBarColors();
		playState.uiGroup.remove(playState.healthBar);
		playState.uiGroup.insert(playState.uiGroup.members.indexOf(this) + 1, playState.healthBar);

		this.forEachAlive((spr) -> spr.antialiasing = ClientPrefs.data.antialiasing);
	}

	override public function updatePost(elapsed:Float):Void
	{
		var curTime:Float = Math.max(0, Conductor.songPosition - ClientPrefs.data.noteOffset);
		var songCalce:Float = FlxG.sound.music.length - curTime;
		var secondsTotal:Int = Math.floor((songCalce / playState.playbackRate / 1000));

		if (cachedTime != secondsTotal)
		{
			cachedTime = secondsTotal;
			timeText.text = FlxStringUtil.formatTime(secondsTotal);
		}

		if (singleDad)
		{
			playState.iconP1.x = playingAsDad ? 555 : -200;
			playState.iconP2.x = playingAsDad ? -200 : 555;
		}
		else if (singleBf)
		{
			playState.iconP1.x = playingAsDad ? -200 : 555;
			playState.iconP2.x = playingAsDad ? 555 : -200;
		}
		else
		{
			playState.iconP1.x = playingAsDad ? 15 : 1100;
			playState.iconP2.x = playingAsDad ? 1100 : 15;
		}
		playState.iconP1.y = playState.iconP2.y = isDownscroll ? 70 : 500;

		var needsReload:Bool = false;
		if (playState.boyfriend.healthColorArray.toString() != bfColors.toString())
		{
			playState.boyfriend.healthColorArray = bfColors.copy();
			needsReload = true;
		}

		if (playState.dad.healthColorArray.toString() != dadColors.toString())
		{
			playState.dad.healthColorArray = dadColors.copy();
			needsReload = true;
		}

		if (needsReload)
			playState.reloadHealthBarColors();
	}

	override public function onBeatHit(beat:Int):Void
	{
		if (beat % 2 == 0 && PlayState.SONG.song != "Syringe")
		{
			if (!playingAsDad)
			{
				if (playState.healthBar.percent < 80)
				{
					playState.iconP2.angle = 20;
					FlxTween.tween(playState.iconP2, {angle: 0}, 0.2, {ease: FlxEase.cubeOut});
				}

				if (playState.healthBar.percent > 20)
				{
					playState.iconP1.angle = -20;
					FlxTween.tween(playState.iconP1, {angle: 0}, 0.2, {ease: FlxEase.cubeOut});
				}
			}
			else
			{
				if (playState.healthBar.percent < 80)
				{
					playState.iconP2.angle = ((PlayState.SONG.song == 'Enraged' || PlayState.SONG.song == 'Isolation' || PlayState.SONG.song == 'Betalation') && !playState.moepart) ? 20 : -20;
					FlxTween.tween(playState.iconP2, {angle: 0}, 0.2, {ease: FlxEase.cubeOut});
				}

				if (playState.healthBar.percent > 20)
				{
					playState.iconP1.angle = 20;
					FlxTween.tween(playState.iconP1, {angle: 0}, 0.2, {ease: FlxEase.cubeOut});
				}
			}
		}

		if (PlayState.SONG.song == "Syringe")
		{
			if (beat % 2 == 0)
				if (playState.healthBar.percent > 20)
				{
					playState.iconP1.angle = -20;
					FlxTween.tween(playState.iconP1, {angle: 0}, 0.2, {ease: FlxEase.cubeOut});
				}

			if (playState.healthBar.percent < 80)
			{
				if (beat % 2 == 0)
					playState.iconP2.angle = 20;
				else if (beat % 2 == 1 && evil)
					playState.iconP2.angle = -20;

				FlxTween.tween(playState.iconP2, {angle: 0}, 0.2, {ease: FlxEase.cubeOut});
			}
		}

		if (PlayState.SONG.song == "Scrub")
		{
			if (beat == 256)
				singleDad = true;
			else if (beat == 288)
				singleDad = false;
		}
	}

	override public function onStepHit(step:Int):Void
	{
		if (PlayState.SONG.song == 'Syringe' && step == 320)
			evil = true;

		if (PlayState.SONG.song == 'Gates Of Hell')
		{
			if (step == 768 || step == 2304)
				singleBf = true;
			else if (step == 2048)
			{
				singleDad = true;
				singleBf = false;
			}
			else if (step == 1536)
				singleBf = singleDad = false;
		}

		if (PlayState.SONG.song == "Last Game")
		{
			if (step == 512)
				singleDad = false;
			else if (step == 768)
				singleDad = true;
			else if (step == 1568)
				singleDad = false;
			else if (step == 1824)
				singleDad = true;
		}

		if (PlayState.SONG.song == "Red Slot")
		{
			if (step == 512)
				singleDad = true;
			else if (step == 1024)
				singleDad = false;
			else if (step == 1536 && !playState.loadedOldSong)
				singleDad = true;
			else if (step == 1408 && playState.loadedOldSong)
				singleDad = true;
		}
	}

	override public function updateScore(score:Int):Void
	{
		scoreText.text = 'S: $score';
	}

	override public function updateMisses(misses:Int):Void
	{
		missesText.text = 'X: $misses';
	}

	override public function updateAccuracy(accuracy:Float):Void
	{
		accuracyText.text = 'A: ${CoolUtil.floorDecimal(accuracy * 100, 2)}%';
	}

	override public function updateScoreText(score:Int, misses:Int, accuracy:Float):Void
	{
		updateScore(score);
		updateMisses(misses);
		updateAccuracy(accuracy);
	}
}
