-- MODIFICATION FOR GATES OF HELL

function onCreatePost()
    setProperty('healthBar.flipX', true)
end

function onBeatHit()
    if (curBeat % 2 == 0) then
        if getProperty('health') <= 1.625 then
            setProperty('iconP2.angle', -20)
            doTweenAngle('bip', 'iconP2', 0, 0.2, 'cubicOut')
        end
        if getProperty('health') >= 0.375 then
            setProperty('iconP1.angle', 20)
            doTweenAngle('bop', 'iconP1', 0, 0.2, 'cubicOut')
        end
    end
end
