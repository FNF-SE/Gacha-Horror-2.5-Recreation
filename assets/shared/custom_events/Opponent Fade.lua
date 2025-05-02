-- Event notes hooks
function onEvent(name, value1, value2)
  if name == 'Opponent Fade' then
    duration = tonumber(value1)
    if duration < 0 then
      duration = 0
    end
    targetAlpha = tonumber(value2)
    if duration == 0 then
      if getProperty('characterPlayingAsDad') == false then
        setProperty('dad.alpha', targetAlpha)
        setProperty('iconP2.alpha', targetAlpha)
      else
        setProperty('boyfriend.alpha', targetAlpha)
        setProperty('iconP1.alpha', targetAlpha)
      end
    else
      if getProperty('characterPlayingAsDad') == false then
        doTweenAlpha('dadFadeEventTween', 'dad', targetAlpha, duration, 'linear')
        doTweenAlpha('iconDadFadeEventTween', 'iconP2', targetAlpha, duration, 'linear')
      else
        doTweenAlpha('bfFadeEventTween', 'boyfriend', targetAlpha, duration, 'linear')
        doTweenAlpha('iconBfFadeEventTween', 'iconP1', targetAlpha, duration, 'linear')
      end
    end
  end
end
