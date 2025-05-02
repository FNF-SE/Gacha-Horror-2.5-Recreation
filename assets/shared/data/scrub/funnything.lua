-- Author: Homura Akemi (HomuHomu833)

local singleBf = false
local singleDad = false

function onBeatHit()
  if curBeat == 256 then
    singleDad = true
  elseif curBeat == 288 then
    singleDad = false
  end
end

function onUpdatePost()
  if singleDad then
    setProperty('iconP1.x', -200)
    setProperty('iconP2.x', 555)
  elseif singleBf then
    setProperty('iconP1.x', 555)
    setProperty('iconP2.x', -200)
  else
    setProperty('iconP2.x', 15)
    setProperty('iconP1.x', 1100)
  end
end
