-- MODIFICATION FOR ISOLATION

local moepart = false

function onCreate()
  setProperty('iconP1.flipX', true)
end

function onUpdatePost()
  setProperty('iconP1.x', 15)
  setProperty('iconP2.x', 1100)
end

function onBeatHit()
  if (curBeat % 2 == 0) then
    if getProperty('health') >= 0.375 then
      setProperty('iconP1.angle', 20)
      doTweenAngle('bop', 'iconP1', 0,0.2,'cubicOut')
    end
  end
  if (curBeat % 2 == 0) and moepart then
    if getProperty('health') <= 1.625 then
      if moepart then
        setProperty('iconP2.angle', -20)
      else
        setProperty('iconP2.angle', 20)
      end
      doTweenAngle('bip', 'iconP2', 0,0.2,'cubicOut')
    end
  end
end
function onStepHit()
  if curStep == 1088 then
    runHaxeCode([[PlayState.instance.changeNoteSkin(false, "noteSkins/MoeArrows");]])
    runHaxeCode([[PlayState.instance.changeNoteSkin(true, "noteSkins/NOTE_assets");]])
    moepart = true
    setProperty('iconP2.flipX', true)
  end
  if curStep == 1344 then
    runHaxeCode([[PlayState.instance.changeNoteSkin(false, "noteSkins/M-O-Arrows");]])
    runHaxeCode([[PlayState.instance.changeNoteSkin(true, "noteSkins/BFArrows");]])
    moepart = false
    setProperty('iconP2.flipX', false)
  end
end
