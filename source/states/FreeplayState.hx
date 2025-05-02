package states;

import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.effects.FlxFlicker;
import substates.GameplayChangersSubstate;
import backend.WeekData;
import backend.Highscore;
import backend.Song;
import flixel.util.FlxSpriteUtil;

class FreeplayState extends MusicBeatState
{
	var menuItems:FlxTypedSpriteGroup<FlxSprite>;
	var menuChar:FlxTypedGroup<FlxSprite>;
	var bg:FlxSprite;
	var bgTop:FlxSprite;
	var tipTextBG:FlxSprite;
	var tipText:FlxText;

	var scoreBG:FlxSprite;
	var scoreTxt:FlxText;
	var lerpScore:Int = 0;
	var lerpRating:Float = 0;
	var intendedScore:Int = 0;
	var intendedRating:Float = 0;

	public static var curSelected:Int = 0;

	public static var songs:Array<String>;

	var selectedSomethin:Bool = false;
	var portraits:String = 'freeplay/menu/Portraits/' + FreeplaySelectState.optionShit[FreeplaySelectState.curSelected] + '/';
	var characterPortraits:String = 'freeplay/menu/CharacterPortraits/' + FreeplaySelectState.optionShit[FreeplaySelectState.curSelected] + '/';
	var selectedOption:FlxSprite;

	public function new()
	{
		super();
	}

	override function create()
	{
		FlxG.mouse.visible = true;
		FreeplaySelectState.setShit();
		if (songs == [] || songs == null)
			FlxG.switchState(new FreeplaySelectState());
		bg = new FlxSprite().loadGraphic(Paths.image(portraits + 'bg'));
		bg.screenCenter();
		bg.antialiasing = ClientPrefs.data.antialiasing;
		add(bg);

		bgTop = new FlxSprite().loadGraphic(Paths.image(portraits + 'bg-top'));
		bgTop.screenCenter();
		bgTop.antialiasing = ClientPrefs.data.antialiasing;
		add(bgTop);

		menuChar = new FlxTypedGroup<FlxSprite>();
		add(menuChar);

		menuItems = new FlxTypedSpriteGroup<FlxSprite>();
		add(menuItems);

		scoreTxt = new FlxText(0, 30, 0, "", 32);
		scoreTxt.setFormat(Paths.font("Comfortaa-Bold.ttf"), 32, FlxColor.WHITE);

		scoreBG = FlxSpriteUtil.drawRoundRect(new FlxSprite(scoreTxt.x - 6, scoreTxt.y).makeGraphic(1, 40, FlxColor.TRANSPARENT), 0, 0, 2, 40, 25, 25,
			0xFF000000);
		scoreBG.alpha = 0.6;
		add(scoreBG);
		add(scoreTxt);

		generateButtons(105);
		menuItems.screenCenter(Y);
		menuItems.y -= 105;

		var leButton:String;
		var leX:Int;

		if (ClientPrefs.data.controlsAlpha >= 0.1)
		{
			leButton = "C";
			leX = 860;
		}
		else
		{
			leButton = "CTRL";
			leX = 830;
		}

		tipText = new FlxText(0, 0, 0, 'Press ' + leButton + ' to open the Gameplay Changers Menu', 18);
		tipText.setFormat("Comfortaa-Bold.ttf", 17, FlxColor.WHITE, LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		tipText.borderSize = 1.25;
		tipText.x += leX;

		tipTextBG = new FlxSprite(tipText.x, 0).makeGraphic(Std.int(tipText.width), 26, 0xFF000000);
		tipTextBG.alpha = 0.6;

		add(tipTextBG);
		add(tipText);

		#if DISCORD_ALLOWED
		// Updating Discord Rich Presence
		DiscordClient.changePresence("In the Menus", null);
		#end

		changeItem(0);
		addTouchPad("NONE", "B_C");
		PlayState.isStoryMode = false;
		super.create();
	}

	override function closeSubState()
	{
		changeItem();
		persistentUpdate = true;
		removeTouchPad();
		addTouchPad("NONE", "B_C");
		super.closeSubState();
	}

	private function positionHighscore()
	{
		scoreBG.scale.x = scoreTxt.width;
		scoreBG.x = scoreBG.scale.x / 2;
	}

	override function update(elapsed:Float)
	{
		lerpScore = Math.floor(FlxMath.lerp(lerpScore, intendedScore, FlxMath.bound(elapsed * 24, 0, 1)));
		lerpRating = FlxMath.lerp(lerpRating, intendedRating, FlxMath.bound(elapsed * 12, 0, 1));
		if (Math.abs(lerpScore - intendedScore) <= 10)
			lerpScore = intendedScore;
		if (Math.abs(lerpRating - intendedRating) <= 0.01)
			lerpRating = intendedRating;
		var ratingSplit:Array<String> = Std.string(CoolUtil.floorDecimal(lerpRating * 100, 2)).split('.');
		if (ratingSplit.length < 2) // No decimals, add an empty space
		{
			ratingSplit.push('');
		}
		while (ratingSplit[1].length < 2) // Less than 2 decimals in it, add decimals then
		{
			ratingSplit[1] += '0';
		}
		scoreTxt.text = 'PERSONAL BEST: ' + lerpScore + ' (' + ratingSplit.join('.') + '%)';
		positionHighscore();
		selectedOption = menuItems.members[curSelected];
		if (!selectedSomethin)
		{
			if (controls.ACCEPT)
			{
				accepted();
			}
			if (controls.UI_UP_P)
			{
				FlxG.sound.play(Paths.sound('scrollMenu'));
				changeItem(-1);
			}
			if (controls.BACK || FlxG.mouse.justReleasedRight)
			{
				selectedSomethin = true;
				FlxG.sound.play(Paths.sound('cancelMenu'));
				MusicBeatState.switchState(new FreeplaySelectState());
			}
			if (controls.UI_DOWN_P)
			{
				FlxG.sound.play(Paths.sound('scrollMenu'));
				changeItem(1);
			}
			if (FlxG.mouse.justMoved)
			{
				for (i in 0...menuItems.length)
				{
					if (i != curSelected && FlxG.mouse.overlaps(menuItems.members[i]))
					{
						curSelected = i;
						FlxG.sound.play(Paths.sound('scrollMenu'));
					}
					changeItem(0);
				}
			}
			if (FlxG.mouse.justPressed)
			{
				if (FlxG.mouse.overlaps(menuItems.members[curSelected]))
				{
					accepted();
				}
			}
			for (i in 0...songs.length)
			{
				if (i == FreeplayState.curSelected)
				{
					menuItems.members[i].alpha = 1;
				}
				else
				{
					menuItems.members[i].alpha = 0.6;
				}
			}
		}
		if (FlxG.keys.justPressed.CONTROL || touchPad.buttonC.justPressed && !selectedSomethin)
		{
			persistentUpdate = false;
			openSubState(new GameplayChangersSubstate());
		}
		super.update(elapsed);
	}

	override function destroy()
	{
		songs = [];
		FlxG.mouse.visible = false;
		super.destroy();
	}

	function generateButtons(sep:Float)
	{
		if (menuItems == null)
			return;

		if (menuItems.members != null && menuItems.members.length > 0)
			menuItems.forEach(function(_:FlxSprite)
			{
				menuItems.remove(_);
				_.destroy();
			});

		for (i in 0...songs.length)
		{
			var str:String = songs[i];
			var songsObj:FlxSprite = new FlxSprite();
			songsObj.loadGraphic(Paths.image(portraits + str), false, 550, 100);
			songsObj.origin.set();
			songsObj.alpha = 0.5;
			songsObj.ID = i;
			if (FreeplaySelectState.curSelected == 1)
				songsObj.setPosition(65, 100 + (i * sep));
			else
				songsObj.setPosition(650, 100 + (i * sep));
			songsObj.width = 550;
			songsObj.height = 100;
			songsObj.offset.x = 20;
			songsObj.offset.y = 150;
			menuItems.add(songsObj);
		}
	}

	function changeItem(huh:Int = 0)
	{
		if (!selectedSomethin)
		{
			curSelected += huh;

			if (curSelected >= menuItems.length)
				curSelected = 0;
			if (curSelected < 0)
				curSelected = menuItems.length - 1;

			intendedScore = Highscore.getScore(songs[curSelected]);
			intendedRating = Highscore.getRating(songs[curSelected]);

			for (i in 0...songs.length)
			{
				if (menuChar.members != null && menuChar.members.length > 0)
					menuChar.forEach(function(_:FlxSprite)
					{
						menuChar.remove(_);
						_.destroy();
					});

				var char:FlxSprite;
				char = new FlxSprite().loadGraphic(Paths.image(characterPortraits + songs[curSelected]));
				char.antialiasing = ClientPrefs.data.antialiasing;
				char.updateHitbox();
				if (songs[curSelected] != 'Scrub' || songs[curSelected] != 'Bread')
					char.screenCenter();
				menuChar.add(char);
			}
		}
	}

	function accepted()
	{
		selectedSomethin = true;
		FlxG.sound.play(Paths.sound('confirmMenu'));
		menuItems.forEach(function(spr:FlxSprite)
		{
			if (curSelected != spr.ID)
			{
				FlxTween.tween(spr, {alpha: 0}, 0.4, {
					ease: FlxEase.quadOut,
					onComplete: function(twn:FlxTween)
					{
						spr.destroy();
					}
				});
			}
			else
			{
				FlxFlicker.flicker(spr, 1, 0.06, false, false, function(flick:FlxFlicker)
				{
					CoolUtil.loadSong(songs[curSelected]);
				});
			}
		});
	}
}

class FreeplaySelectState extends MusicBeatState
{
	public static var curSelected:Int = 0;
	public static var optionShit:Array<String> = ['v1', 'v2', 'comeback', 'joke'];
	public static var selectedTutorial:Bool = false;

	var menuItems:FlxTypedGroup<FlxSprite>;
	var bg:FlxSprite;
	var tutText:FlxText;
	var selectedButton:FlxSprite;

	override function create()
	{
		Paths.clearStoredMemory();
		Paths.clearUnusedMemory();

		FlxG.mouse.visible = true;

		persistentUpdate = persistentDraw = true;

		bg = new FlxSprite().loadGraphic(Paths.image('freeplay/select/BG'));
		bg.antialiasing = ClientPrefs.data.antialiasing;
		add(bg);

		menuItems = new FlxTypedGroup<FlxSprite>();
		add(menuItems);

		generateButtons(300);
		var textString:String = "Press the DOWN arrow for the Tutorial";
		tutText = new FlxText(0, 0, FlxG.width, textString, 50, true);
		tutText.setFormat(Paths.font("Comfortaa-Bold.ttf"), 50, FlxColor.WHITE);
		tutText.screenCenter();
		add(tutText);
		tutText.y += 295;
		tutText.x += 125;

		#if DISCORD_ALLOWE
		// Updating Discord Rich Presence
		DiscordClient.changePresence("In the Menus", null);
		#end

		changeItem();

		addTouchPad("UP_DOWN", "B");

		super.create();
	}

	override function closeSubState()
	{
		changeItem();
		persistentUpdate = true;
		super.closeSubState();
		removeTouchPad();
		addTouchPad("UP_DOWN", "B");
	}

	var selectedSomethin:Bool = false;

	override function update(elapsed:Float)
	{
		selectedButton = menuItems.members[curSelected];
		if (!selectedSomethin)
		{
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

			if (controls.UI_UP_P)
			{
				selectedSomethin = true;
				MusicBeatState.switchState(new FreeplayStateOld());
			}

			if (controls.BACK || FlxG.mouse.justReleasedRight)
			{
				selectedSomethin = true;
				FlxG.sound.play(Paths.sound('cancelMenu'));
				MusicBeatState.switchState(new MainMenuState());
			}
			if (controls.UI_DOWN_P)
			{
				selectedSomethin = true;
				FlxG.sound.play(Paths.sound('confirmMenu'));
				FlxFlicker.flicker(tutText, 1, 0.06, false, false, function(flick:FlxFlicker)
				{
					selectedTutorial = true;
					CoolUtil.loadSong('tutorial');
				});
			}

			if (FlxG.mouse.justMoved)
			{
				for (i in 0...menuItems.length)
				{
					if (i != curSelected && FlxG.mouse.overlaps(menuItems.members[i]))
					{
						curSelected = i;
						FlxG.sound.play(Paths.sound('scrollMenu'));
					}
					changeItem(0);
				}
			}
			if (FlxG.mouse.justPressed)
			{
				if (FlxG.mouse.overlaps(menuItems.members[curSelected]))
				{
					accepted();
				}
			}

			if (controls.ACCEPT)
			{
				accepted();
			}
			for (i in 0...optionShit.length)
			{
				if (i == FreeplaySelectState.curSelected)
				{
					menuItems.members[i].alpha = 1;
					menuItems.members[i].scale.set(1.2, 1.2);
				}
				else
				{
					menuItems.members[i].alpha = 0.5;
					menuItems.members[i].scale.set(1, 1);
				}
			}
		}

		super.update(elapsed);
	}

	function generateButtons(sep:Float)
	{
		if (menuItems == null)
			return;

		if (menuItems.members != null && menuItems.members.length > 0)
			menuItems.forEach(function(_:FlxSprite)
			{
				menuItems.remove(_);
				_.destroy();
			});

		for (i in 0...optionShit.length)
		{
			var str:String = optionShit[i];

			var freeplayItem:FlxSprite = new FlxSprite();
			freeplayItem.loadGraphic(Paths.image('freeplay/select/' + str));
			freeplayItem.ID = i;
			freeplayItem.origin.set();
			freeplayItem.alpha = 0.5;
			freeplayItem.antialiasing = ClientPrefs.data.antialiasing;
			freeplayItem.setPosition(75 + (i * sep), 0);
			freeplayItem.screenCenter(Y);
			freeplayItem.updateHitbox();
			menuItems.add(freeplayItem);
		}
	}

	public function changeItem(huh:Int = 0)
	{
		curSelected += huh;

		if (curSelected >= menuItems.length)
			curSelected = 0;
		if (curSelected < 0)
			curSelected = menuItems.length - 1;
	}

	public static function setShit()
	{
		switch (curSelected)
		{
			case 0: // v1 songs
				FreeplayState.songs = ['Despair', 'Isolation', 'Sentient', 'Red-Slot'];
			case 1: // v2 songs
				FreeplayState.songs = ['Far-Lost', 'Gates-Of-Hell', 'Syringe', 'Malfunction', 'Betrayal', 'Bloodshed'];
			case 2: // comeback songs
				FreeplayState.songs = ['Crisis', 'Last-Game', 'Impairment', 'Enraged'];
			case 3: // joke songs
				FreeplayState.songs = ['Scrub', 'Bread', 'Betalation'];
		}
	}

	function accepted()
	{
		selectedSomethin = true;
		FlxG.sound.play(Paths.sound('confirmMenu'));
		setShit();
		menuItems.forEach(function(spr:FlxSprite)
		{
			if (curSelected != spr.ID)
			{
				FlxTween.tween(spr, {alpha: 0}, 0.4, {
					ease: FlxEase.quadOut,
					onComplete: function(twn:FlxTween)
					{
						spr.destroy();
					}
				});
			}
			else
			{
				FlxFlicker.flicker(spr, 1, 0.06, false, false, function(flick:FlxFlicker)
				{
					MusicBeatState.switchState(new FreeplayState());
				});
			}
		});
	}

	override function destroy()
	{
		FlxG.mouse.visible = false;
		super.destroy();
	}
}
