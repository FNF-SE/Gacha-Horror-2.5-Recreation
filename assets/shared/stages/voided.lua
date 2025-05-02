function onCreate()
  makeLuaSprite('bg', 'stages/Voider/bg', -720, -50)
  setScrollFactor('bg', 0.9, 0.9)
  scaleObject('bg', 2.6, 2.4)

  makeLuaSprite('back', 'stages/Voider/back', -600, -100)
  setScrollFactor('back', 0.9, 0.9)
  scaleObject('back', 1.7, 1.7)

  makeLuaSprite('front', 'stages/Voider/front', -700, -250)
  setScrollFactor('front', 0.9, 0.9)
  scaleObject('front', 2.0, 2.0)

  makeLuaSprite('dablack', 'dablack', -700, -250)
  setScrollFactor('dablack', 0.9, 0.9)
  scaleObject('dablack', 3.0, 3.0)

  makeLuaSprite('black', 'black', -700, -250)
  setScrollFactor('black', 0.9, 0.9)
  scaleObject('black', 3.0, 3.0)

  if not lowQuality then
    makeAnimatedLuaSprite('Azan','stages/Voider/Azan',1000,210)
    addAnimationByPrefix('Azan','idle','idle',24,true)
    objectPlayAnimation('Azan','idle',false)
    setScrollFactor('Azan', 0.9, 0.9)
    scaleObject('Azan', 0.6, 0.6)
  end

  addLuaSprite('bg', false)
  addLuaSprite('back', false)
  addLuaSprite('front', true)
  if not lowQuality then
    addLuaSprite('Azan', false)
  end
  addLuaSprite('dablack', true)
  addLuaSprite('black', true)

  close(true)
end

function onBeatHit()
  if curBeat % 2 == 5 then
    objectPlayAnimation('Azan', 'idle', 15)
  end
end
