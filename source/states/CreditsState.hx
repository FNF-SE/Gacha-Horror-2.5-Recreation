package states;

class CreditsState extends MusicBeatState
{
	public static var curSelected:Int = 0;

	var menuItems:FlxTypedGroup<FlxSprite>;
	var shit:Array<String> = [
		'lily',
		'Red Diamond',
		'Adolfo',
		'NotFahi',
		'Azan',
		'Usser',
		'Fifi',
		'Maxxii',
		'Syahrilishere',
		'Code Magnet',
		'Alex',
		'Crimm',
		'mouseman',
		'Kaede'
	];
	var exit:FlxSprite;

	override function create()
	{
		FlxG.mouse.visible = true;
		menuItems = new FlxTypedGroup<FlxSprite>();
		add(menuItems);

		#if DISCORD_ALLOWED
		// Updating Discord Rich Presence
		DiscordClient.changePresence("In the Menus", null);
		#end

		exit = new FlxSprite(1130, 0).makeGraphic(240, 88, FlxColor.TRANSPARENT);
		add(exit);
		changeItem();
		addTouchPad("LEFT_RIGHT", "NONE");

		super.create();
	}

	override function update(elapsed:Float)
	{
		if (controls.BACK || FlxG.mouse.justReleasedRight || (FlxG.mouse.justPressed && FlxG.mouse.overlaps(exit)))
		{
			FlxG.sound.play(Paths.sound('cancelMenu'));
			MusicBeatState.switchState(new MainMenuState());
		}
		if (controls.UI_LEFT_P)
		{
			FlxG.sound.play(Paths.sound('scrollMenu'));
			changeItem(-1);
		}
		if (controls.UI_RIGHT_P)
		{
			FlxG.sound.play(Paths.sound('scrollMenu'));
			changeItem(1);
		}
		super.update(elapsed);
	}

	function changeItem(huh:Int = 0)
	{
		curSelected += huh;

		if (curSelected >= shit.length)
			curSelected = 0;
		if (curSelected < 0)
			curSelected = shit.length - 1;

		for (i in 0...shit.length)
		{
			if (menuItems.members != null && menuItems.members.length > 0)
				menuItems.forEach(function(_:FlxSprite)
				{
					menuItems.remove(_);
					_.destroy();
				});

			var imageItem:FlxSprite;
			imageItem = new FlxSprite().loadGraphic(Paths.image('credits/' + shit[curSelected]));
			imageItem.antialiasing = ClientPrefs.data.antialiasing;
			imageItem.updateHitbox();
			menuItems.add(imageItem);
		}
	}

	override function destroy()
	{
		FlxG.mouse.visible = false;
		super.destroy();
	}
}
