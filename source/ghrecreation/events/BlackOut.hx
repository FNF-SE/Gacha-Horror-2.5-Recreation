package events;

import objects.Note.EventNote;

class BlackOut extends backend.BaseStage
{
	public static final name:String = 'BlackOut';

	override function eventPushed(event:EventNote)
	{
		if (event.event != name) return;

        game.flashBlackOut = new FlxSprite(0, 0).makeGraphic(FlxG.width * 2, FlxG.height * 2, FlxColor.BLACK);
		game.flashBlackOut.offset.set(FlxG.width / 2, FlxG.height / 2);
		game.flashBlackOut.scrollFactor.set(0, 0);
		game.flashBlackOut.alpha = 0;
		game.flashBlackOut.draw(); // so it does not lag when it flashs for first time
		game.add(game.flashBlackOut);
    }

	override function eventCalled(eventName:String, value1:String, value2:String, flValue1:Null<Float>, flValue2:Null<Float>, strumTime:Float)
	{
		if (eventName != name) return;

		game.flashBlackOut.alpha = value1 == "true" ? 1 : 0;
	}
		
}