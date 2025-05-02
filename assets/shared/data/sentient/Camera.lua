function onCreatePost()
  CamOffsetDad_X = 100

  CamOffsetDad_Y = 170

  --the camera points for each char
  CamPointDad_X = getProperty('dad.x')+CamOffsetDad_X
  CamPointDad_Y = getProperty('dad.y')+CamOffsetDad_Y
end

local MoveCamDad=50
EnemyNoteFuncs = { --IM DRUNK WOOOOOOOOOO
  [1] = function() --left note
    triggerEvent('Camera Follow Pos', CamPointDad_X-MoveCamDad, CamPointDad_Y)
  end,
  [2]=function() --down note
    triggerEvent('Camera Follow Pos', CamPointDad_X, CamPointDad_Y+MoveCamDad)
  end,
  [3]=function() --up note
    triggerEvent('Camera Follow Pos', CamPointDad_X, CamPointDad_Y-MoveCamDad)
  end,
  [4]=function()--right note
    triggerEvent('Camera Follow Pos', CamPointDad_X+MoveCamDad, CamPointDad_Y)
  end
}

function onBeatHit()
  if curBeat%2==0 then
    if mustHitSection == false and getProperty('dad.animation.curAnim.name') == 'idle' then
      triggerEvent('Camera Follow Pos', '', '')
    elseif mustHitSection == true and getProperty('boyfriend.animation.curAnim.name') == 'idle' then
      triggerEvent('Camera Follow Pos', '', '')
    end
  end
end
