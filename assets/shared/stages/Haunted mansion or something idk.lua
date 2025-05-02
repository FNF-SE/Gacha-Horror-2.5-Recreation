function onCreate()
  makeLuaSprite('bg', 'stages/Creepy Cutie shinaniganz/bg', -300, -70)
  setScrollFactor('bg', 0.9, 0.9)
  scaleObject('bg', 1.8, 1.6)

  if not lowQuality then
    makeLuaSprite('tre', 'stages/Creepy Cutie shinaniganz/tre', -400, -90)
    setScrollFactor('tre', 1.5, 1.5)
    scaleObject('tre', 1.6, 2.3)

    makeLuaSprite('tre2', 'stages/Creepy Cutie shinaniganz/tre2', 900, -90)
    setScrollFactor('tre2', 1.5, 1.5)
    scaleObject('tre2', 1.6, 2.3)
  end

  makeLuaSprite('black', 'black', -600, 67)
  setScrollFactor('black', 0.9, 0.9)
  scaleObject('black', 3.8, 3.2)

  makeLuaSprite('blair bg', 'stages/Creepy Cutie shinaniganz/blair bg', 30, 30)
  setScrollFactor('blair bg', 0.9, 0.9)
  scaleObject('blair bg', 1.1, 1.1)

  addLuaSprite('blair bg', false)
  addLuaSprite('bg', false)
  if not lowQuality then
    addLuaSprite('tre', true)
    addLuaSprite('tre2', true)
  end
  addLuaSprite('black', false)
end

function onBeatHit()
  if curBeat == 192 and songName == "Despair" then
    setProperty('bg.visible', false)
    if not lowQuality then
      setProperty('tre.visible', false)
      setProperty('tre2.visible', false)
    end
  elseif curBeat == 256 and songName == "Despair" then
    setProperty('bg.visible', true)
    if not lowQuality then
      setProperty('tre.visible', true)
      setProperty('tre2.visible', true)
    end
  end
end
