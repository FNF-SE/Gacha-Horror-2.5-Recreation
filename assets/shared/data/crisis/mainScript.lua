local width = 0
local height = 0

function onCreate()
    if buildTarget == 'android' or buildTarget == 'ios' then
        width = math.floor(math.abs(getPropertyFromClass('flixel.FlxG', 'stage.stageWidth')))
        height = math.floor(math.abs(getPropertyFromClass('flixel.FlxG', 'stage.stageHeight')))
    else
        width = math.floor(math.abs(getPropertyFromClass('openfl.system.Capabilities', 'screenResolutionX')))
        height = math.floor(math.abs(getPropertyFromClass('openfl.system.Capabilities', 'screenResolutionY')))
    end
end

function onCreatePost()
    setPropertyFromClass('openfl.Lib', 'application.window.fullscreen', true)
    makeLuaSprite('BlackScreenHUD', 'empty', -550, -150)
    makeGraphic('BlackScreenHUD', 2500, 1920, '000000')
    setObjectCamera('BlackScreenHUD', 'hud')
    addLuaSprite('BlackScreenHUD', false)
    setProperty("BlackScreenHUD.visible", false)
end

function onDestroy()
    resetWindow()
end

function onBeatHit()
    if curBeat == 92 then
        setProperty("BlackScreenHUD.visible", true)
    end
    if curBeat == 96 then
        setProperty("BlackScreenHUD.visible", false)
        cameraFlash('hud', '000000', 3, true)
    end
    if curBeat == 256 then
        resetWindow()
    end
    if curBeat == 384 then
        resetWindow()
    end
    if curBeat == 576 then
        resetWindow()
    end
end

function onEndSong()
    resetWindow()
end

function onGameOver()
    resetWindow()
end

function resetWindow()
    if buildTarget == 'android' or buildTarget == 'ios' then
        setPropertyFromClass('openfl.Lib', 'application.window.width', width)
        setPropertyFromClass('openfl.Lib', 'application.window.height', height)
    end
    setPropertyFromClass('openfl.Lib', 'application.window.fullscreen', true)
end
