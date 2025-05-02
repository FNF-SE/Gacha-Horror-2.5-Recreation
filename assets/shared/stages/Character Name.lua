function onCreate()
  makeLuaSprite('bg', 'stages/Character Name/bg', -240, -50)
  setScrollFactor('bg', 0.9, 0.9)
  scaleObject('bg', 1.6, 1.4)

  if not lowQuality then
    makeLuaSprite('blur left', 'stages/Character Name/blur left', -400, 350)
    setScrollFactor('blur left', 1.5, 0.9)
    scaleObject('blur left', 1.6, 1.6)

    makeLuaSprite('blur right', 'stages/Character Name/blur right', 1250, 350)
    setScrollFactor('blur right', 1.5, 0.9)
    scaleObject('blur right', 1.6, 1.6)

    makeLuaSprite('Left', 'stages/Character Name/Left', -400, 200)
    setScrollFactor('Left', 0.9, 0.9)
    scaleObject('Left', 1.6, 1.6)

    makeLuaSprite('Right', 'stages/Character Name/Right', 550, 200)
    setScrollFactor('Right', 0.9, 0.9)
    scaleObject('Right', 1.6, 1.6)
  end

  makeLuaSprite('dablack', 'dablack', -240, -50)
  setScrollFactor('dablack', 0.9, 0.9)
  scaleObject('dablack', 3.6, 3.4)

  makeLuaSprite('black', 'black', 550, 200)
  setScrollFactor('black', 0.9, 0.9)
  scaleObject('black', 3.6, 3.6)

  makeLuaSprite('black2', 'black', 550, 200)
  setScrollFactor('black2', 0.9, 0.9)
  scaleObject('black2', 3.6, 3.6)

  addLuaSprite('bg', false)
  if not lowQuality then
    addLuaSprite('blur left', true)
    addLuaSprite('blur right', true)
    addLuaSprite('Left', false)
    addLuaSprite('Right', false)
  end
  addLuaSprite('dablack', true)
  addLuaSprite('black', true)
  addLuaSprite('black2', true)

  close(true)
end
