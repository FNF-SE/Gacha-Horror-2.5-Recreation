-- Author: Homura Akemi (HomuHomu833)

local singleBf = false
local singleDad = false

function onCreate()
  singleDad = true
end

function onStepHit()
  if curStep == 512 then
    singleDad = false
  elseif curStep == 768 then
    singleDad = true
  elseif curStep == 1568 then
    singleDad = false
  elseif curStep == 1824 then
    singleDad = true
    --elseif curStep == 2448 then
    --singleDad = false
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
