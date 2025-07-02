function onCreate()
    makeLuaSprite('BlackFlash', 'dablack', -700, -700)
    scaleObject('BlackFlash', 24, 28)
    addLuaSprite('BlackFlash', true)
    setProperty('BlackFlash.visible', false)
end

function onEvent(name, value1, value2)
    if name == 'BlackOut' then
        if value1 == 'true' then
            setProperty('BlackFlash.visible', true)
        elseif value1 == 'false' then
            setProperty('BlackFlash.visible', false)
        end
    end
end
