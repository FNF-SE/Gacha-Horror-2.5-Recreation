package events;

import objects.Note.EventNote;

class FlashCamera extends backend.BaseStage
{
	public static final name:String = 'Flash Camera';

	override function eventPushed(event:EventNote)
	{
		if (event.event != name) return;

        game.flashWhite = new FlxSprite(0, 0).makeGraphic(FlxG.width * 2, FlxG.height * 2, FlxColor.WHITE);
		game.flashWhite.offset.set(FlxG.width / 2, FlxG.height / 2);
		game.flashWhite.scrollFactor.set(0, 0);
		game.flashWhite.alpha = 0;
		game.flashWhite.draw(); // so it does not lag when it flashs for first time
		game.add(game.flashWhite);
    }

	override function eventCalled(eventName:String, value1:String, value2:String, flValue1:Null<Float>, flValue2:Null<Float>, strumTime:Float)
	{
		if (eventName != name) return;

		game.flashBlack.visible = false;
		game.flashWhite.alpha = 1;
		game.flashTween = FlxTween.tween(game.flashWhite, {alpha: 0}, flValue1 ?? 0.1, {ease: FlxEase.linear});
	}
}