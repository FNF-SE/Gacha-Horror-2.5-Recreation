package events;

import objects.Note.EventNote;

class BlackFlashCamera extends backend.BaseStage
{
	public static final name:String = 'Black Flash Camera';
	public var flash:FlxSprite;

	override function eventPushed(event:EventNote)
	{
		if (event.event != name) return;

        flash = new FlxSprite(0, 0).makeGraphic(FlxG.width * 2, FlxG.height * 2, FlxColor.BLACK);
		flash.offset.set(FlxG.width / 2, FlxG.height / 2);
		flash.scrollFactor.set(0, 0);
		flash.alpha = 0;
		flash.draw(); // so it does not lag when it flashs for first time
		game.add(flash);
    }

	override function eventCalled(eventName:String, value1:String, value2:String, flValue1:Null<Float>, flValue2:Null<Float>, strumTime:Float)
	{
		if (eventName != name) return;

		flash.alpha = 1;
		FlxTween.tween(flash, {alpha: 0}, flValue1 ?? 0.1, {ease: FlxEase.linear});
	}
}