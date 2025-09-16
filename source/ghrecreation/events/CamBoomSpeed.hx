package events;

import objects.Note.EventNote;

class CamBoomSpeed extends BaseStage
{
    public static final name:String = "Cam Boom Speed";

    var boomspeed:Int = 4;
    var bam:Float = 1;

    override function eventCalled(eventName:String, value1:String, value2:String, flValue1:Null<Float>, flValue2:Null<Float>, strumTime:Float)
    {
        if (eventName != name) return;

        boomspeed = Std.int(flValue1);
        bam = flValue2;
    }

    override function beatHit()
    {
        if (boomspeed == 0) return;
        
        if (curBeat % boomspeed == 0)
            game.triggerEvent("Add Camera Zoom", Std.string(0.015 * bam), Std.string(0.03 * bam), Conductor.songPosition);
    }
}