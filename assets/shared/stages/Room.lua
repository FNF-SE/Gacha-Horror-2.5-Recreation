function onCreate()
  makeLuaSprite('roomwblood', 'stages/high/roomwblood', -150, -170)
  setScrollFactor('roomwblood', 0.9, 0.9)
  scaleObject('roomwblood', 1.9, 1.7)

  if not lowQuality then
    makeLuaSprite('bookswblood', 'stages/high/bookswblood', -150, 180)
    setScrollFactor('bookswblood', 0.9, 0.9)
    scaleObject('bookswblood', 1.0, 1.0)
  end

  makeLuaSprite('room', 'stages/high/room', -150, -170)
  setScrollFactor('room', 0.9, 0.9)
  scaleObject('room', 1.9, 1.7)

  if not lowQuality then
    makeLuaSprite('books', 'stages/high/books', -150, 180)
    setScrollFactor('books', 0.9, 0.9)
    scaleObject('books', 1.0, 1.0)
  end

  makeLuaSprite('noob', 'stages/high/noob', 450, 490)
  setScrollFactor('noob', 0.9, 0.9)
  scaleObject('noob', 0.7, 0.7)

  makeLuaSprite('dablack', 'dablack', -150, -170)
  setScrollFactor('dablack', 0.9, 0.9)
  scaleObject('dablack', 1.9, 1.7)

  makeLuaSprite('black', 'black', -150, -170)
  setScrollFactor('black', 0.9, 0.9)
  scaleObject('black', 1.9, 1.7)

  addLuaSprite('roomwblood', false)
  if not lowQuality then
    addLuaSprite('bookswblood', true)
  end
  addLuaSprite('noob', false)
  addLuaSprite('room', false)
  if not lowQuality then
    addLuaSprite('books', true)
  end
  addLuaSprite('dablack', true)
  addLuaSprite('black', true)

  close(true)
end
