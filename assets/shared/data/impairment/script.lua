function onCreatePost()
  makeLuaSprite('BlackScreen', 'empty', -550,-150)
  makeGraphic('BlackScreen', 2500, 1920, '000000')
  addLuaSprite('BlackScreen', false)
  setProperty("BlackScreen.visible", false)

  makeLuaSprite('BlackScreenHUD', 'empty', -550,-150)
  makeGraphic('BlackScreenHUD', 2500, 1920, '000000')
  setObjectCamera('BlackScreenHUD', 'hud')
  addLuaSprite('BlackScreenHUD', false)
  setProperty("BlackScreenHUD.visible", false)

  makeLuaText("Captions", "", 1200, 55, 515)
  addLuaText("Captions", true)
  setTextSize("Captions", 30)
  setTextBorder("Captions", 2, "30AAEE")
  setTextColor("Captions", "D7E274")
  setTextFont("Captions", "Comfortaa-Bold.ttf")
  setTextAlignment("Captions", "center")

  makeLuaSprite('ErrorBG', 'stages/Character Name/TVCN/Background', -670,-90)
  addLuaSprite('ErrorBG', false)
  scaleObject('ErrorBG', 1.25,1.25)
  setProperty('ErrorBG.visible', false)

  if not lowQuality then
    makeLuaSprite('StoryBtn', 'stages/Character Name/TVCN/STORYMODE', -530,-30)
    addLuaSprite('StoryBtn', false)
    setProperty('StoryBtn.visible', false)

    makeLuaSprite('FreeplayBtn', 'stages/Character Name/TVCN/FREEPLAY', 430,-30)
    addLuaSprite('FreeplayBtn', false)
    setProperty('FreeplayBtn.visible', false)

    makeLuaSprite('ArrowPurp', 'stages/Character Name/TVCN/PURPLEARROW', -530,230)
    scaleObject('ArrowPurp', 0.65,0.65)
    addLuaSprite('ArrowPurp', true)
    setProperty('ArrowPurp.visible', false)

    makeLuaSprite('ArrowBlue', 'stages/Character Name/TVCN/BLUEARROW', -390,430)
    scaleObject('ArrowBlue', 0.75,0.75)
    addLuaSprite('ArrowBlue', true)
    setProperty('ArrowBlue.visible', false)

    makeLuaSprite('ArrowGree', 'stages/Character Name/TVCN/GREENARROW', 410,430)
    scaleObject('ArrowGree', 0.65,0.65)
    addLuaSprite('ArrowGree', true)
    setProperty('ArrowGree.visible', false)

    makeLuaSprite('ArrowRed', 'stages/Character Name/TVCN/REDARROW', 610,230)
    scaleObject('ArrowRed', 0.65,0.65)
    addLuaSprite('ArrowRed', true)
    setProperty('ArrowRed.visible', false)
  end
end

function onBeatHit()
  if curBeat == 192 then
    setProperty("BlackScreenHUD.visible", true)
  end
  if curBeat == 196 then
    setProperty("BlackScreenHUD.visible", false)
    if not flashingLights then
      cameraFlash('hud', 'FFFFFF', 0.35, true)
    end
    setProperty("BlackScreen.visible", true)
    setProperty('blur left.visible', false)
    setProperty('blur right.visible', false)

    setProperty('ErrorBG.visible', true)
    if not lowQuality then
      setProperty('StoryBtn.visible', true)
      setProperty('FreeplayBtn.visible', true)
      setProperty('ArrowPurp.visible', true)
      setProperty('ArrowBlue.visible', true)
      setProperty('ArrowGree.visible', true)
      setProperty('ArrowRed.visible', true)
    end

    if not middlescroll then
      noteTweenX("NoteMove1", 4, 435, 1, 'cubeOut')
      noteTweenX("NoteMove2", 5, 545, 1, 'cubeOut')
      noteTweenX("NoteMove3", 6, 655, 1, 'cubeOut')
      noteTweenX("NoteMove4", 7, 765, 1, 'cubeOut')

      noteTweenAngle("NoteAngle1", 4, -360, 1, 'cubeOut')
      noteTweenAngle("NoteAngle2", 5, -360, 1, 'cubeOut')
      noteTweenAngle("NoteAngle3", 6, -360, 1, 'cubeOut')
      noteTweenAngle("NoteAngle4", 7, -360, 1, 'cubeOut')
    end

    noteTweenAlpha("NoteMove5", 0, 0, 0.01, 'cubeOut')
    noteTweenAlpha("NoteMove6", 1, 0, 0.01, 'cubeOut')
    noteTweenAlpha("NoteMove7", 2, 0, 0.01, 'cubeOut')
    noteTweenAlpha("NoteMove8", 3, 0, 0.01, 'cubeOut')
  end

  if curBeat == 260 then
    if flashingLights then
      cameraFlash('hud', 'FFFFFF', 1, true)
    end
  end

  if curBeat == 324 then
    if flashingLights then
      cameraFlash('hud', 'FFFFFF', 1, true)
    end
  end
end

function onStepHit()
  if curStep == 1040 then
    setTextString("Captions", "THE PITS OF HELL")
  end
  if curStep == 1052 then
    setTextString("Captions", "SUMMONING JUST FOR YOU")
  end
  if curStep == 1072 then
    setTextString("Captions", "HOPEFULLY YOU'LL SURVIVE")
  end
  if curStep == 1088 then
    setTextString("Captions", "TO MAKE IT THROUGH")
  end
  if curStep == 1104 then
    setTextString("Captions", "BODIES MUTILATING")
  end
  if curStep == 1120 then
    setTextString("Captions", "FOR THEIR OWN GOOD")
  end
  if curStep == 1136 then
    setTextString("Captions", "YOU")
  end
  if curStep == 1140 then
    setTextString("Captions", "YOU WILL")
  end
  if curStep == 1144 then
    setTextString("Captions", "YOU WILL NOT")
  end
  if curStep == 1148 then
    setTextString("Captions", "YOU WILL NOT LIVE")
  end
  if curStep == 1152 then
    setTextString("Captions", "YOU'RE")
  end
  if curStep == 1156 then
    setTextString("Captions", "YOU'RE MIS")
  end
  if curStep == 1160 then
    setTextString("Captions", "YOU'RE MISUN")
  end
  if curStep == 1164 then
    setTextString("Captions", "YOU'RE MISUNDER")
  end
  if curStep == 1168 then
    setTextString("Captions", "YOU'RE MISUNDERSTOOD")
  end
  if curStep == 1184 then
    setTextString("Captions", " ")
  end
  if curStep == 1192 then
    setTextString("Captions", "BACK")
  end
  if curStep == 1200 then
    setTextString("Captions", "BACK OFF")
  end
  if curStep == 1216 then
    setTextString("Captions", " ")
  end
  if curStep == 1224 then
    setTextString("Captions", "STAND")
  end
  if curStep == 1232 then
    setTextString("Captions", "STAND DOWN")
  end
  if curStep == 1248 then
    setTextString("Captions", " ")
  end
  if curStep == 1260 then
    setTextString("Captions", "I")
  end
  if curStep == 1264 then
    setTextString("Captions", "I WILL")
  end
  if curStep == 1272 then
    setTextString("Captions", "I WILL TAKE")
  end
  if curStep == 1280 then
    setTextString("Captions", "I WILL TAKE THE")
  end
  if curStep == 1288 then
    setTextString("Captions", "I WILL TAKE THE CROWN")
  end
  if curStep == 1296 then
    setTextString("Captions", " ")
  end
end


function onUpdate(elapsed)
  if curStep >= 0 and not lowQuality then
    songPos = getSongPosition()
    local currentBeat = (songPos/1000)*(bpm/80)
    doTweenY('purpTween', 'ArrowPurp', 230-10*math.sin((currentBeat*0.25)*math.pi),0.001)
    doTweenY('blueTween', 'ArrowBlue', 430-10*math.sin((currentBeat*0.4)*math.pi),0.001)
    doTweenY('greenTween', 'ArrowGree', 430-10*math.sin((currentBeat*0.5)*math.pi),0.001)
    doTweenY('redTween', 'ArrowRed', 230-10*math.sin((currentBeat*0.75)*math.pi),0.001)
    doTweenY('storyTween', 'StoryBtn', -30-10*math.sin((currentBeat*-0.25)*math.pi),0.001)
    doTweenY('freeplayTween', 'FreeplayBtn', -30-10*math.sin((currentBeat*-0.5)*math.pi),0.001)
  end
end
