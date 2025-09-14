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
    private var isDownscroll:Bool = ClientPrefs.data.downScroll;
    private var cachedTime:Int = 0;

    public function new(playState:PlayState)
    {
        super();

        this.playState = playState;
        scoreUpdateType = ScoreUpdateTypes.SEPERATE;

        isDownscroll = ClientPrefs.data.downScroll;

        fields.set('topBar', add(topBar = new FlxSprite(345, isDownscroll ? -20 : 640).loadGraphic(Paths.image("hudassets/topBar"))));
        fields.set('scoreBar', add(scoreBar = new FlxSprite(176, isDownscroll ? 0 : 643).loadGraphic(Paths.image("hudassets/bar"))));
        fields.set('accuracyBar', add(accuracyBar = new FlxSprite(0, isDownscroll ? 0 : 643).loadGraphic(Paths.image("hudassets/bar"))));
        fields.set('songBar', add(songBar = new FlxSprite(973, isDownscroll ? 0 : 671).loadGraphic(Paths.image("hudassets/songName"))));

        topBar.flipY = !isDownscroll;
                
        fields.set('scoreText', cast(add(scoreText = new FlxText(162, isDownscroll ? 20 : 665, 180, "S: ?")), FlxText));
        fields.set('missesText', cast(add(missesText = new FlxText(326, isDownscroll ? 18 : 662, 200, "X: ?")), FlxText));
        fields.set('accuracyText', cast(add(accuracyText = new FlxText(-12, isDownscroll ? 20 : 665, 180, "A: N/A")), FlxText));
        fields.set('timeText', cast(add(timeText = new FlxText(714, isDownscroll ? 18 : 662, 205, " ")), FlxText));
        fields.set('songText', cast(add(songText = new FlxText(518, isDownscroll ? 5 : 676, 1235, playState.songName)), FlxText));

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

        playState.iconP1.x = 1100;
        playState.iconP1.y = isDownscroll ? 70 : 500;
        playState.iconP2.x = 15;
        playState.iconP2.y = isDownscroll ? 70 : 500;

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

        if (needsReload) playState.reloadHealthBarColors();
    }

    override public function onBeatHit(beat:Int):Void
    {
        if (beat % 2 == 0) {
            if (playState.health <= 1.625) {                
                playState.iconP2.angle = 20;
                FlxTween.tween(playState.iconP2, {angle: 0}, 0.2, {ease: FlxEase.cubeOut});
            }
            if (playState.health >= 0.375) {           
                playState.iconP1.angle = -20;
                FlxTween.tween(playState.iconP1, {angle: 0}, 0.2, {ease: FlxEase.cubeOut});
            }
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
}