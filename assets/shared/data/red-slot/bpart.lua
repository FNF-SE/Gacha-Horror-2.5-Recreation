function onStepHit()
  if not lowQuality then
    Particle()
  end
end
f = 1

function Particle()
  songPos = getSongPosition()
  currentBeat = (songPos/500)
  f = f + 1
  sus = math.random(2, 1500)
  sus2 = math.random(2, 1500)
  makeLuaSprite('bpart' .. f, 'bparticles', math.random(500, 2000), 1600)
  doTweenY(sus, 'bpart' .. f, -900*math.tan((currentBeat+1*0.1)*math.pi), 6)
  doTweenX(sus2, 'bpart' .. f, -900*math.sin((currentBeat+1*0.1)*math.pi), 6)
  scaleObject('bpart' .. f, 0.5, 0.5)

  addLuaSprite('bpart' .. f, true)

  if f >= 50 then
    f = 1
  end
end
