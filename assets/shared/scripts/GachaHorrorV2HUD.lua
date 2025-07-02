-- Author: Homura Akemi (HomuHomu833) and Karim Akra
local dadcolor = "61D9B3"
local bfcolor = "505A8F"
local firstnote = false
local fakescore = 0
local fakeaccuracy = 0

function onCreate()
    addHaxeLibrary('FlxStringUtil', 'flixel.util')
    addHaxeLibrary("ClientPrefs", 'backend')
    addHaxeLibrary("Conductor", 'backend')
    addHaxeLibrary("CoolUtil", 'backend')

    if not downscroll then
        topBarY = 640
        topBarFlipY = true
        songNameY = 671
        accuracyBarY = 643
        scoreBarY = 643
        healthBarExtraY = 13
        songTxtY = 676
        durationTxtY = 662
        scoreCTxtY = 665
        missesTxtY = 662
        accuracyTxtY = 665
        iconP1Y = 500
        iconP2Y = 500
    else
        topBarY = -20
        topBarFlipY = false
        songNameY = 0
        accuracyBarY = 0
        scoreBarY = 0
        healthBarExtraY = -28
        songTxtY = 5
        durationTxtY = 18
        scoreCTxtY = 20
        missesTxtY = 18
        accuracyTxtY = 20
        iconP1Y = 70
        iconP2Y = 70
    end

    makeLuaSprite('topBar', "hudassets/topBar", 345, topBarY)
    setProperty('topBar.flipY', topBarFlipY)
    setObjectCamera('topBar', 'hud')
    addLuaSprite('topBar', true)

    makeLuaSprite('songName', 'hudassets/songName', 973, songNameY)
    setObjectCamera('songName', 'hud')
    addLuaSprite('songName', true)

    makeLuaSprite('accuracyBar', 'hudassets/bar', 0, accuracyBarY)
    setObjectCamera('accuracyBar', 'hud')
    addLuaSprite('accuracyBar', true)

    makeLuaSprite('scoreBar', 'hudassets/bar', 176, scoreBarY)
    setObjectCamera('scoreBar', 'hud')
    addLuaSprite('scoreBar', true)

    makeLuaText('songTxt', '' .. (songName), 1235, 518, songTxtY)
    setTextFont('songTxt', 'Comfortaa-Bold.ttf')
    setTextSize('songTxt', 36)
    setObjectCamera('songTxt', 'hud')
    addLuaText('songTxt')

    makeLuaText('durationTxt', ' ', 205, 714, durationTxtY)
    setTextFont('durationTxt', 'Comfortaa-Bold.ttf')
    setTextSize('durationTxt', 34)
    setObjectCamera('durationTxt', 'hud')
    addLuaText('durationTxt')

    makeLuaText('scoreCTxt', 'S: ?', 180, 162, scoreCTxtY)
    setTextFont('scoreCTxt', 'Comfortaa-Bold.ttf')
    setTextSize('scoreCTxt', 30)
    setObjectCamera('scoreCTxt', 'hud')
    addLuaText('scoreCTxt')

    makeLuaText('missesTxt', 'X: ?', 200, 326, missesTxtY)
    setTextFont('missesTxt', 'Comfortaa-Bold.ttf')
    setTextSize('missesTxt', 30)
    setObjectCamera('missesTxt', 'hud')
    addLuaText('missesTxt')

    makeLuaText('accuracyTxt', 'A: N/A', 180, -12, accuracyTxtY)
    setTextFont('accuracyTxt', 'Comfortaa-Bold.ttf')
    setTextSize('accuracyTxt', 30)
    setObjectCamera('accuracyTxt', 'hud')
    addLuaText('accuracyTxt')
end

function onCreatePost()
    setProperty('timeBar.visible', false)
    setProperty('timeBar.bg.visible', false)
    setProperty('timeTxt.visible', false)
    setProperty('scoreTxt.visible', false)
    setProperty('botplayTxt.visible', false)
    setProperty('healthBar.x', getProperty("healthBar.x") - 18)
    setProperty('healthBar.bg.x', getProperty("healthBar.bg.x") - 18)
    setProperty('healthBar.y', getProperty("healthBar.y") + healthBarExtraY)
    setProperty('healthBar.bg.y', getProperty("healthBar.bg.y") + healthBarExtraY)
    setObjectOrder('scoreBar', 7)
    setObjectOrder('accuracyBar', 6)
    setObjectOrder('songName', 5)
    setObjectOrder('topBar', 4)
    setObjectOrder('healthBar.bg', 3)
    setObjectOrder('healthBar', 2)
end

function onUpdate(elapsed)
    if botPlay then
        runHaxeCode(
            [[var curTimee:Float = Math.max(0, Conductor.songPosition - ClientPrefs.data.noteOffset);var songCalce:Float = (]] ..
                songLength .. [[ - curTimee);var secondsTotal:Int = Math.floor((songCalce/]] .. playbackRate ..
                [[) / 1000);]] .. [[game.getLuaObject("]] .. "durationTxt" ..
                [[", true).text = FlxStringUtil.formatTime(secondsTotal);]])
        runHaxeCode([[game.getLuaObject("]] .. "accuracyTxt" .. [[", true).text = 'A: ' + ]] .. fakeaccuracy ..
                        [[ + "%";]])
        setTextString("scoreCTxt", "S: " .. fakescore)
    else
        runHaxeCode(
            [[var curTimee:Float = Math.max(0, Conductor.songPosition - ClientPrefs.data.noteOffset);var songCalce:Float = (]] ..
                songLength .. [[ - curTimee);var secondsTotal:Int = Math.floor((songCalce/]] .. playbackRate ..
                [[) / 1000);]] .. [[game.getLuaObject("]] .. "durationTxt" ..
                [[", true).text = FlxStringUtil.formatTime(secondsTotal);game.getLuaObject("]] .. "accuracyTxt" ..
                [[", true).text = 'A: ' + CoolUtil.floorDecimal(]] .. rating .. [[*100, 2) + "%";]])
        setTextString("scoreCTxt", "S: " .. score)
    end
    setTextString("missesTxt", "X: " .. misses)
end

function onUpdatePost()
    setHealthBarColors(bfcolor, dadcolor)
    setProperty('iconP1.x', 1100)
    setProperty('iconP1.y', iconP1Y)
    setProperty('iconP2.x', 15)
    setProperty('iconP2.y', iconP2Y)
end

function goodNoteHit(i, d, t, s)
    if botPlay then
        if not firstnote then
            fakeaccuracy = 100
            firstnote = true
        end
        if not s then
            fakescore = fakescore + 300
        end
    end
end

function onBeatHit()
    if (curBeat % 2 == 0) then
        if getProperty('health') <= 1.625 then
            setProperty('iconP2.angle', 20)
            doTweenAngle('bip', 'iconP2', 0, 0.2, 'cubicOut')
        end
        if getProperty('health') >= 0.375 then
            setProperty('iconP1.angle', -20)
            doTweenAngle('bop', 'iconP1', 0, 0.2, 'cubicOut')
        end
    end
end
