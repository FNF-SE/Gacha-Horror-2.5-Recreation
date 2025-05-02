function onCreate()
  -- precache stuff
  addCharacterToList('Red person lol', 'dad')
  precacheImage('noteSkins/RedSlotArrows')
end

function onCreatePost()
  makeLuaSprite('BlackScreen', 'empty', -50,-50)
  makeGraphic('BlackScreen', 1920, 1920, '000000')
  setObjectCamera('BlackScreen', 'hud')
  addLuaSprite('BlackScreen', false)
  setProperty("BlackScreen.visible", true)

  makeLuaSprite('RedSlotPart', 'empty', -1000,-1000)
  makeGraphic('RedSlotPart', 3400, 3400, 'FF0000')
  setObjectCamera('RedSlotPart', 'game')
  addLuaSprite('RedSlotPart', false)

  setProperty("RedSlotPart.visible", false)

  makeLuaText("Captions", " ", 1200, 55, 515)
  addLuaText("Captions", true)
  setTextSize("Captions", 30)
  setTextBorder("Captions", 2, "007700")
  setTextColor("Captions", "004400")
  setTextFont("Captions", "Comfortaa-Bold.ttf")
  setTextAlignment("Captions", "center")
end

function onSongStart()
  if flashingLights then
    cameraFlash('hud', 'FFFFFF', 0.35, true)
  end
  setProperty("BlackScreen.visible", false)
end

function onBeatHit()
  if curBeat == 60 then
    setProperty("BlackScreen.visible", true)
    setTextString("Captions", "AUUUUUUUUUGHHHHHHH")
  end
  if curBeat == 64 then
    if flashingLights then
      cameraFlash('hud', 'FFFFFF', 0.35, true)
    end
    setProperty("BlackScreen.visible", false)
    setTextString("Captions", " ")
  end
  if curBeat == 252 then
    setProperty("BlackScreen.visible", true)
    setTextString("Captions", "AMONG US!!1!!1!!111!!")
  end
  if curBeat == 256 then
    setTextString("Captions", " ")
    setProperty("BlackScreen.visible", false)
    if flashingLights then
      cameraFlash('hud', 'FF0000', 0.75, true)
    end
    setProperty("RedSlotPart.visible", true)
    runHaxeCode([[PlayState.instance.changeNoteSkin(false, "noteSkins/RedSlotArrows");]])
  end
  if curBeat == 280 then
    setProperty("BlackScreen.visible", true)
    setTextString("Captions", "AUUUUUUUUUGHHHHHHH")
  end
  if curBeat == 284 then
    triggerEvent("Screen Shake", "1.25, 0.1", "1.25, 0.1")
  end
  if curBeat == 288 then
    if flashingLights then
      cameraFlash('hud', 'FFFFFF', 0.35, true)
    end
    setProperty("BlackScreen.visible", false)
    setTextString("Captions", " ")
    setProperty("RedSlotPart.visible", false)
    runHaxeCode([[PlayState.instance.changeNoteSkin(false, "noteSkins/MikeArrows");]])
  end
end
