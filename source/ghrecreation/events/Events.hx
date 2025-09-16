package events;

class Events
{
	public static var events:Array<Class<BaseStage>> = [BetterCinematic];

	public static function initEvents():Void
	{
		for (event in events)
		{
			trace('Initializing event: ${Type.getClassName(event)}');
			Type.createInstance(event, []);
		}
	}
}
