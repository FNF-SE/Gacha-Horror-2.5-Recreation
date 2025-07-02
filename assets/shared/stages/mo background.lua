function onCreate()
    makeLuaSprite('moe', 'stages/mo/moe', -600, 67)
    setScrollFactor('moe', 0.9, 0.9)
    scaleObject('moe', 1.6, 1.2)

    makeLuaSprite('mo', 'stages/mo/mo', -1000, -190)
    setScrollFactor('mo', 0.9, 0.9)
    scaleObject('mo', 2.2, 1.8)

    makeLuaSprite('dablack', 'dablack', -600, 32)
    setScrollFactor('dablack', 0.9, 0.9)
    scaleObject('dablack', 1.9, 1.2)

    makeLuaSprite('black', 'black', -600, 32)
    setScrollFactor('black', 0.9, 0.9)
    scaleObject('black', 3.6, 3.2)

    if not lowQuality and not getProperty('loadedOldSong') then
        makeAnimatedLuaSprite('JGGHD', 'stages/mo/JGGHD', 400, 100)
        addAnimationByPrefix('JGGHD', 'idle', 'idle', 24, true)
        objectPlayAnimation('JGGHD', 'idle', false)
        setScrollFactor('JGGHD', 0.9, 0.9)
        scaleObject('JGGHD', 0.7, 0.7)
    end

    addLuaSprite('moe', false)
    addLuaSprite('mo', false)
    if not lowQuality and not getProperty('loadedOldSong') then
        addLuaSprite('JGGHD', false)
    end
    addLuaSprite('dablack', true)
    addLuaSprite('black', true)

    close(true)
end

function onBeatHit()
    -- if curBeat % 2 == 0 then
    objectPlayAnimation('JGGHD', 'idle', 13)
    -- end
end
