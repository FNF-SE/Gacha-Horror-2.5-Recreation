package events;

class Events
{
	// oh boy this is gonna be LONG...
	public static var events:Array<Class<BaseStage>> = [
		BetterCinematic,
		BlackFlashCamera,
		BlackOut,
		CamBoomSpeed
	];

	public static function initEvents():Void
	{
		for (event in events)
		{
			trace('Initializing event: ${Type.getClassName(event)}');
			Type.createInstance(event, []);
		}
	}
}
