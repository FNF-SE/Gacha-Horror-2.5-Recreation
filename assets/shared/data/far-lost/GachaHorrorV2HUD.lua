-- MODIFICATION FOR FAR LOST

function onCreate()
    setProperty('iconP1.flipX', true)
    setProperty('iconP2.flipX', true)
end

function onUpdatePost()
    setProperty('iconP1.x', 15)
    setProperty('iconP2.x', 1100)
end

function onBeatHit()
    if (curBeat % 2 == 0) then
        if getProperty('health') >= 0.375 then
            setProperty('iconP1.angle', 20)
            doTweenAngle('bop', 'iconP1', 0, 0.2, 'cubicOut')
        end
        if getProperty('health') <= 1.625 then
            setProperty('iconP2.angle', -20)
            doTweenAngle('bip', 'iconP2', 0, 0.2, 'cubicOut')
        end
    end
end
