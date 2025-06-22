package states;

#if (target.threaded)
import sys.thread.Thread;
import sys.thread.Mutex;
#end

class GalleryState extends MusicBeatState
{
	var background:FlxSprite;

	var curSelected:Int = 0;

	var items:FlxTypedGroup<FlxSprite>;
	var itemImages:Array<String> = [
		'AfrhaGachaYT',
		'DevinHandoko',
		'irfan._',
		'KoLsiq12',
		'Leafy_2.0',
		'Lynn',
		'miyamixx',
		'noriz_zez',
		'NotFahi',
		'Smashfanbro',
		'StarWantsCookie',
		'Usser'
	];
	#if (target.threaded) var mutex:Mutex = new Mutex(); #end

	override function create()
	{
		Paths.clearStoredMemory();
		Paths.clearUnusedMemory();

		if (FlxG.sound.music != null)
			FlxG.sound.music.stop();
		#if (target.threaded)
		Thread.create(() -> {
			mutex.acquire();
		#end
			FlxG.sound.playMusic(Paths.music('galleryTheme'), 0.7);
		#if (target.threaded)
		mutex.release();
		});
		#end
		background = new FlxSprite().loadGraphic(Paths.image('gallerymenu/BG'));
		background.antialiasing = ClientPrefs.data.antialiasing;
		background.updateHitbox();
		background.screenCenter();
		add(background);

		items = new FlxTypedGroup<FlxSprite>();
		add(items);

		#if DISCORD_ALLOWED
		// Updating Discord Rich Presence
		DiscordClient.changePresence("In the Menus", null);
		#end

		changeItem();
		addTouchPad("LEFT_RIGHT", "B");

		super.create();
	}

	override function update(elapsed:Float)
	{
		if (controls.BACK || FlxG.mouse.justReleasedRight)
		{
			if (FlxG.sound.music != null)
				FlxG.sound.music.stop();
			FlxG.sound.playMusic(Paths.music('freakyMenu'), 0.7);
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

		if (curSelected >= itemImages.length)
			curSelected = 0;
		if (curSelected < 0)
			curSelected = itemImages.length - 1;

		for (i in 0...itemImages.length)
		{
			if (items.members != null && items.members.length > 0)
				items.forEach(function(_:FlxSprite)
				{
					items.remove(_);
					_.destroy();
				});

			var imageItem:FlxSprite;
			imageItem = new FlxSprite().loadGraphic(Paths.image('gallerymenu/Portraits/' + itemImages[curSelected]));
			imageItem.antialiasing = ClientPrefs.data.antialiasing;
			imageItem.updateHitbox();
			imageItem.screenCenter();
			items.add(imageItem);
		}
	}
}
