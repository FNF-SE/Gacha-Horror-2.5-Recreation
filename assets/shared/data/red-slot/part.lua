function onStepHit()
  if not lowQuality and not getProperty('loadedOldSong') then
    Particle()
  end
end
f = 2

function Particle()
  songPos = getSongPosition()
  currentBeat = (songPos/500)
  f = f + 1
  sus = math.random(2, 1500)
  sus2 = math.random(2, 1500)
  makeLuaSprite('part' .. f, 'bparticles', math.random(500, 2000), 1600)
  doTweenY(sus, 'part' .. f, -900*math.tan((currentBeat+1*0.1)*math.pi), 6)
  doTweenX(sus2, 'part' .. f, -900*math.sin((currentBeat+1*0.1)*math.pi), 6)
  scaleObject('part' .. f, 0.4, 0.4)

  addLuaSprite('part' .. f, false)

  if f >= 50 then
    f = 2
  end
end
