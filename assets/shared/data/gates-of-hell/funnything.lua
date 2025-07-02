-- Author: Homura Akemi (HomuHomu833)

local singleBf = false
local singleDad = false

function onStepHit()
    if curStep == 768 or curStep == 2304 then
        singleBf = false
        singleDad = true
    elseif curStep == 2048 then
        singleBf = true
        singleDad = false
    elseif curStep == 1536 then
        singleBf = false
        singleDad = false
    end
end

function onUpdatePost()
    if singleBf then
        setProperty('iconP1.x', 555)
        setProperty('iconP2.x', -200)
    elseif singleDad then
        setProperty('iconP1.x', -200)
        setProperty('iconP2.x', 555)
    else
        setProperty('iconP1.x', 15)
        setProperty('iconP2.x', 1100)
    end
end
