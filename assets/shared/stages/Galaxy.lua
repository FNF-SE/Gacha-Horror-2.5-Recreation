function onCreate()
    makeLuaSprite('galaxii', 'black', -300, -70)
    setScrollFactor('galaxii', 0.9, 0.9)
    scaleObject('galaxii', 1.8, 1.6)

    makeAnimatedLuaSprite('Galaxy', 'stages/Galaxy', -500, -200)
    addAnimationByPrefix('Galaxy', 'galaxyidle', 'Galaxy Idle', 60, true)
    setScrollFactor('Galaxy', 0.9, 0.9)
    scaleObject('Galaxy', 4.0, 4.0)

    addLuaSprite('galaxii', false)
    addLuaSprite('Galaxy', false)
end
