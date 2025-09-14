package objects;

import objects.HUDImpl.ScoreUpdateTypes;

class BaseHUD extends flixel.group.FlxSpriteGroup implements HUDImpl
{
    public var instance:BaseHUD;
    public var fields:Map<String, Dynamic>;
    public var scoreUpdateType:ScoreUpdateTypes;

    public function new()
    {
        super();

        instance = this;
        fields = new Map<String, Dynamic>();
        scoreUpdateType = ScoreUpdateTypes.SINGLE;
    }

    public function create():Void {}
    public function createPost():Void {}
    public function updatePost(elapsed:Float):Void {}
    public function onBeatHit(beat:Int):Void {}
    public function onStepHit(step:Int):Void {}
    public function updateScoreText(score:Int, misses:Int, accuracy:Float):Void {}
    public function updateScore(score:Int):Void {}
    public function updateMisses(misses:Int):Void {}
    public function updateAccuracy(accuracy:Float):Void {}
}