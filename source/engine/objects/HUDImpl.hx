package objects;

import haxe.ds.Map;

interface HUDImpl extends flixel.util.FlxDestroyUtil.IFlxDestroyable
{
    public var instance:BaseHUD;
    public var fields:Map<String, Dynamic>;
    public var scoreUpdateType:ScoreUpdateTypes;

    public function create():Void;
    public function createPost():Void;
    public function updateScoreText(score:Int, misses:Int, accuracy:Float):Void;
    public function updateScore(score:Int):Void;
    public function updateMisses(misses:Int):Void;
    public function updateAccuracy(accuracy:Float):Void;
    public function update(elapsed:Float):Void;
    public function updatePost(elapsed:Float):Void;   
    public function onBeatHit(beat:Int):Void;
    public function onStepHit(step:Int):Void;
}

enum ScoreUpdateTypes
{
    SINGLE;
    SEPERATE;
}