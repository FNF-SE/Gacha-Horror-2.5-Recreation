package events;

import objects.Note.EventNote;

class BlackFlashCamera extends backend.BaseStage
{
	public static final name:String = 'Black Flash Camera';

	override function eventPushed(event:EventNote)
	{
		if (event.event != name) return;

        game.flashBlack = new FlxSprite(0, 0).makeGraphic(FlxG.width * 2, FlxG.height * 2, FlxColor.BLACK);
		game.flashBlack.offset.set(FlxG.width / 2, FlxG.height / 2);
		game.flashBlack.scrollFactor.set(0, 0);
		game.flashBlack.alpha = 0;
		game.flashBlack.draw(); // so it does not lag when it flashs for first time
		game.add(game.flashBlack);
    }

	override function eventCalled(eventName:String, value1:String, value2:String, flValue1:Null<Float>, flValue2:Null<Float>, strumTime:Float)
	{
		if (eventName != name) return;

		game.flashBlack.visible = true;
		game.flashBlack.alpha = 1;
		FlxTween.tween(game.flashBlack, {alpha: 0}, flValue1 ?? 0.1, {ease: FlxEase.linear});
	}
}