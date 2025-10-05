package events;

import objects.Note.EventNote;

class RedFlashCamera extends backend.BaseStage
{
	public static final name:String = 'Red Flash Camera';

	override function eventPushed(event:EventNote)
	{
		if (event.event != name) return;

        game.flashRed = new FlxSprite(0, 0).makeGraphic(FlxG.width * 2, FlxG.height * 2, FlxColor.RED);
		game.flashRed.offset.set(FlxG.width / 2, FlxG.height / 2);
		game.flashRed.scrollFactor.set(0, 0);
		game.flashRed.alpha = 0;
		game.flashRed.draw(); // so it does not lag when it flashs for first time
		game.add(game.flashRed);
    }

	override function eventCalled(eventName:String, value1:String, value2:String, flValue1:Null<Float>, flValue2:Null<Float>, strumTime:Float)
	{
		if (eventName != name) return;

		game.flashBlack.visible = false;
		game.flashRed.alpha = 1;
		game.flashTween = FlxTween.tween(game.flashRed, {alpha: 0}, flValue1 ?? 0.1, {ease: FlxEase.linear});
	}
}