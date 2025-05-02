function onCreate()
  makeLuaSprite('Muu bg', 'stages/Muu bg', -600, -400)
  setScrollFactor('Muu bg', 0.9, 0.9)
  scaleObject('Muu bg', 1.6, 2.6)

  makeLuaSprite('black', 'black', -600, 67)
  setScrollFactor('black', 0.9, 0.9)
  scaleObject('black', 3.6, 3.2)

  addLuaSprite('Muu bg', false)
  addLuaSprite('black', true)

  close(true)
end
