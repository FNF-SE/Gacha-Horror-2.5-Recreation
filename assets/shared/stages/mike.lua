function onCreate()
    makeLuaSprite('mess', 'stages/mess', -300, -70)
    setScrollFactor('mess', 0.9, 0.9)
    scaleObject('mess', 1.8, 1.6)

    addLuaSprite('mess', false)

    close(true)
end
