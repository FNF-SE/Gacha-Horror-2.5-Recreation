function onCreate()
    makeLuaSprite('NormalBG', 'stages/NurseLuck/Normal', -160, -60)
    setScrollFactor('NormalBG', 0.9, 0.9)
    scaleObject('NormalBG', 2.25, 2.25)
    setProperty('NormalBG.visible', true)

    makeLuaSprite('BloodyBG', 'stages/NurseLuck/Bloody', -160, -60)
    scaleObject('BloodyBG', 2.25, 2.25)
    setProperty('BloodyBG.visible', false)

    addLuaSprite('NormalBG', false)
    addLuaSprite('BloodyBG', false)
end

function onBeatHit()
    if curBeat == 80 then
        setProperty('NormalBG.visible', false)
        setProperty('BloodyBG.visible', true)
    end
end
