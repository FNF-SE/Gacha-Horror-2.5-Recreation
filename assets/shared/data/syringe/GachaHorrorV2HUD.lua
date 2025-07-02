-- MODIFICATIN FOR SYRINGE

local evil = false

function onBeatHit()
    if getProperty('health') <= 1.625 then
        if (curBeat % 2 == 0) then
            setProperty('iconP2.angle', 20)
            doTweenAngle('bip', 'iconP2', 0, 0.2, 'cubicOut')
        elseif (curBeat % 2 == 1) and evil then
            setProperty('iconP2.angle', -20)
            doTweenAngle('bip', 'iconP2', 0, 0.2, 'cubicIn')
        end
    end
end

function onStepHit()
    if curStep == 320 then
        evil = true
    end
end
