function onStartCountdown(elapsed)
    doTweenAngle('turn', 'camGame', 1.5, crochet / 300, 'sineInOut')
end

function onTweenCompleted(t)
    if t == 'turn' then
        doTweenAngle('turn1', 'camGame', -1.5, crochet / 300, 'sineInOut')
    end
    if t == 'turn1' then
        doTweenAngle('turn', 'camGame', 1.5, crochet / 300, 'sineInOut')
    end
end
