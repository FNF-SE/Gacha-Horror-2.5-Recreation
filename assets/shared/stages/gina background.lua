function onCreate()
    makeLuaSprite('bottom', 'stages/Ginabg/bottom', -200, 50)
    setScrollFactor('bottom', 0.9, 0.9)
    scaleObject('bottom', 0.7, 0.7)

    makeLuaSprite('top', 'stages/Ginabg/top', -200, 50)
    setScrollFactor('top', 0.9, 0.9)
    scaleObject('top', 0.7, 0.7)

    makeLuaSprite('black', 'black', -200, 50)
    setScrollFactor('black', 0.9, 0.9)
    scaleObject('black', 2, 2)

    addLuaSprite('bottom', false)
    addLuaSprite('top', true)
    addLuaSprite('black', false)

    close(true)
end
