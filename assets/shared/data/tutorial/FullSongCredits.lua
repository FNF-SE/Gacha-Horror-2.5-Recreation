local songdata = {
  --yes i used the pico week bc i didnt wanna interfere with the old version
  ['Tutorial'] = {
    'Tutorial', -- Song Name [1]
    'NotFahi', -- Composer [2]
    '3', --  Length for onscreen [3]
  },

-- Replace this data with your songs and the song composer.
-- The song name in the [] MUST be the same song in the JSON file
-- The Next two are just string values, have fun :3
}

local offsetX = 10
local offsetY = 500
local objWidth = 500


function ifExists(table, valuecheck) -- This stupid function stops your game from throwing up errors when you play a main week song thats not in the Song Data Folder
  if table[valuecheck] then
    return true
else
  return false
end
end


function onCreatePost() -- This creates all the placeholder shit B) ((THIS PART OF THE SCRIPT WAS MADE BY PIGGY))
  --luaDebugMode = true

  makeLuaSprite('creditBox', 'empty', 0 - objWidth, offsetY)
  makeGraphic('creditBox', objWidth, 100, '000000')
  setObjectCamera('creditBox', 'other')
  setProperty("creditBox.alpha", 0.7)
  addLuaSprite('creditBox', true)

  makeLuaText('creditTitle', 'PlaceholderTitle', objWidth, offsetX - objWidth, offsetY+0)
  setTextSize('creditTitle', 45)
  setTextAlignment('creditTitle', 'left')
  setObjectCamera('creditTitle', 'other')
  addLuaText("creditTitle",true)

  makeLuaText('creditComposer', 'PlaceholderComposer', objWidth, offsetX - objWidth, offsetY+45)
  setTextSize('creditComposer', 30)
  setTextAlignment('creditComposer', 'left')
  setObjectCamera('creditComposer', 'other')
  addLuaText("creditComposer",true)

  makeLuaText('creditArtist', 'PlaceholderArtist', objWidth, offsetX - objWidth, offsetY+80)
  setTextSize('creditArtist', 30)
  setTextAlignment('creditArtist', 'left')
  setObjectCamera('creditArtist', 'other')
  addLuaText("creditArtist",true)

  makeLuaText('creditCharter', 'PlaceholderCharter', objWidth, offsetX - objWidth, offsetY+115)
  setTextSize('creditCharter', 30)
  setTextAlignment('creditCharter', 'left')
  setObjectCamera('creditCharter', 'other')
  addLuaText("creditCharter",true)

  -- If you dont NOT want the art and charter credits (or a mix of two), the value used in the old version is:
  -- offsetY+25 for creditTitle
  -- offsetY+80 for the other credit (be it Composer, Charting, or Art)
end


function onSongStart()

  songExists = ifExists(songdata, songName) -- Checks to see if song exists

  if songExists == true then
    local curSongTable = songdata[songName]
    setTextString('creditTitle', curSongTable[1]) -- Sets the actual things
    setTextString('creditComposer', "Composed By: "..curSongTable[2])

    --Tweens--
    doTweenX("creditBoxTween", "creditBox", getProperty("creditBox.x") + objWidth, 1, "expoOut")
    doTweenX("creditTitleTween", "creditTitle", getProperty("creditTitle.x") + objWidth, 1, "expoOut")
    doTweenX("creditComposerTween", "creditComposer", getProperty("creditComposer.x") + objWidth, 1, "expoOut")
    runTimer("creditDisplay",curSongTable[3],1)
  else



  end
end

function onTimerCompleted(timerName)

  if timerName == "creditDisplay" then
    doTweenX("creditBoxTween", "creditBox", getProperty("creditBox.x") - objWidth, 0.9, "sineIn")
    doTweenX("creditTitleTween", "creditTitle", getProperty("creditTitle.x") - objWidth, 0.9, "sineIn")
    doTweenX("creditComposerTween", "creditComposer", getProperty("creditComposer.x") - objWidth, 0.9, "sineIn")
  end

end
