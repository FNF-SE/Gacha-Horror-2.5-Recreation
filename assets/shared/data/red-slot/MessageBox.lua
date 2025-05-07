-- Author: Homura Akemi (HomuHomu833)

function onEndSong()
  if not getProperty('loadedOldSong') then
    runHaxeCode([[CoolUtil.showPopUp('YOU ARE DEAD', ' ');]])
  else
    runHaxeCode([[CoolUtil.showPopUp(' ', ' ');]])
  end
end
