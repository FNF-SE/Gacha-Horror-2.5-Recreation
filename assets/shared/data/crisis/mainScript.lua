function onCreatePost()
  setPropertyFromClass('openfl.Lib', 'application.window.fullscreen', true)
  makeLuaSprite('BlackScreenHUD', 'empty', -550,-150)
  makeGraphic('BlackScreenHUD', 2500, 1920, '000000')
  setObjectCamera('BlackScreenHUD', 'hud')
  addLuaSprite('BlackScreenHUD', false)
  setProperty("BlackScreenHUD.visible", false)
end

function onDestroy()
  setPropertyFromClass('openfl.Lib', 'application.window.fullscreen', true)
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
    setPropertyFromClass('openfl.Lib', 'application.window.fullscreen', true)
  end
  if curBeat == 384 then
    setPropertyFromClass('openfl.Lib', 'application.window.fullscreen', true)
  end
  if curBeat == 576 then
    setPropertyFromClass('openfl.Lib', 'application.window.fullscreen', true)
  end
end

function onEndSong()
  setPropertyFromClass('openfl.Lib', 'application.window.fullscreen', true)
end

function onGameOver()
  setPropertyFromClass('openfl.Lib', 'application.window.fullscreen', true)
end
