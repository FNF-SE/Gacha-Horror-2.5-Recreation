package events;


class BetterCinematic extends backend.BaseStage
{
    public var upperBar:FlxSprite;
    public var lowerBar:FlxSprite;

    var upperBarY:Float = 0;
    var lowerBarY:Float = 0;
    var strumY:Float = 0;
    var defaultPlayerStrumX:Array<Float> = [];
    var defaultPlayerStrumY:Array<Float> = [];
    var defaultOpponentStrumX:Array<Float> = [];
    var defaultOpponentStrumY:Array<Float> = [];
    var hudAssets:Array<FlxSprite> = [];

    override function createPost()
    {
        hudAssets = [
            game.healthBar, game.healthBar.bg,
            game.timeBar, game.timeBar.bg,
            game.iconP1, game.iconP2,
            game.hud.fields.get('accuracyBar'),
            game.hud.fields.get('scoreBar'),
            game.hud.fields.get('topBar'),
            game.hud.fields.get('songBar'),
            game.hud.fields.get('accuracyText'),
            game.hud.fields.get('scoreText'),
            game.hud.fields.get('timeText'),
            game.hud.fields.get('missesText'),
            game.hud.fields.get('songText')
        ];

        upperBar = new FlxSprite(-110, -350);
        upperBar.makeGraphic(1500, 350, CoolUtil.colorFromString("000000"));
        upperBar.cameras = [camHUD];
        game.add(upperBar);

        lowerBar = new FlxSprite(-110, 720);
        lowerBar.makeGraphic(1500, 350, CoolUtil.colorFromString("000000"));
        lowerBar.cameras = [camHUD];
        game.add(lowerBar);
    
        upperBarY = upperBar.y;
        lowerBarY = lowerBar.y;
    }

    override function eventCalled(eventName:String, value1:String, value2:String, flValue1:Null<Float>, flValue2:Null<Float>, strumTime:Float)
	{
        if (eventName != "Better Cinematic") return;

        
        var speed:Float = flValue1;
        var distance:Float = flValue2;
        trace('called better cinematic with speed: ${speed} and distance: ${distance}');

        if (speed > 0 && distance > 0)
        {
            var strumsPush:Float = ClientPrefs.data.downScroll ? 20 : -20;
            FlxTween.tween(upperBar, {y: upperBarY + distance}, speed, {ease: FlxEase.quadOut});
            FlxTween.tween(lowerBar, {y: lowerBarY - distance}, speed, {ease: FlxEase.quadOut});

            if (game.cpuControlled)
                FlxTween.tween(game.botplayTxt, {y: distance + 63}, speed, {ease: FlxEase.quadOut});

            for (obj in hudAssets)
            {
                FlxTween.tween(obj, {alpha: 0}, speed - 0.1, {ease: FlxEase.linear});
            }

            for (i => oppY in defaultOpponentStrumY)
            {
                FlxTween.tween(game.opponentStrums.members[i], {y: oppY + distance + strumsPush}, speed, {ease: FlxEase.quadOut});
            }

            for (i => playerY in defaultPlayerStrumY)
            {
                FlxTween.tween(game.playerStrums.members[i], {y: playerY + distance + strumsPush}, speed, {ease: FlxEase.quadOut});
            }
        }

        if (distance <= 0)
        {
            var strumsPush:Float = ClientPrefs.data.downScroll ? 20 : -20;
            FlxTween.tween(upperBar, {y: upperBarY}, speed, {ease: FlxEase.quadIn});
            FlxTween.tween(lowerBar, {y: lowerBarY}, speed, {ease: FlxEase.quadIn});

            if (game.cpuControlled)
                FlxTween.tween(game.botplayTxt, {y: 83}, speed, {ease: FlxEase.quadOut});

            for (obj in hudAssets)
            {
                FlxTween.tween(obj, {alpha: 1}, speed + 0.1, {ease: FlxEase.linear});
            }

            for (i => oppY in defaultOpponentStrumY)
            {
                FlxTween.tween(game.opponentStrums.members[i], {y: oppY}, speed, {ease: FlxEase.quadOut});
            }

            for (i => playerY in defaultPlayerStrumY)
            {
                FlxTween.tween(game.playerStrums.members[i], {y: playerY}, speed, {ease: FlxEase.quadOut});
            }
        }
	}

    override function countdownTick(count:Countdown, num:Int)
    {
        if (count == START)
        {
            for (i in 0...game.playerStrums.length)
		    {
                defaultPlayerStrumX[i] = game.playerStrums.members[i].x;
                defaultPlayerStrumY[i] = game.playerStrums.members[i].y;
		    }

		    for (i in 0...game.opponentStrums.length)
		    {
                defaultOpponentStrumX[i] =  game.opponentStrums.members[i].x;
                defaultOpponentStrumY[i] =  game.opponentStrums.members[i].y;
		    }
        }
    }
}