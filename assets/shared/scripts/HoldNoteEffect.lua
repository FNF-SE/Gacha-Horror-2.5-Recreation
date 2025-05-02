frameRate = 24
noteR = {0, 7}
colors = {"Purple", "Blue", "Green", "Red", "Purple", "Blue", "Green", "Red"}
HSpashes = {}

function onCreate()
  if not getPropertyFromClass('states.PlayState', 'isPixelStage') then
    for i = noteR[1], noteR[2], 1 do
      local i_s = tostring(i)
      makeAnimatedLuaSprite(i_s, "HoldNoteEffect/holdCover"..colors[i+1])
      setObjectCamera(i_s, "hud")
      addAnimationByPrefix(i_s, i_s, "holdCover"..colors[i+1], frameRate, true)
      addAnimationByPrefix(i_s, i_s.."p", "holdCoverEnd"..colors[i+1], frameRate, false)
      addLuaSprite(i_s, true)
      setProperty(i_s..".visible", false)
      HSpashes["note"..i_s] = {color=colors[i+1], isPlaying=false, Boom=false}
    end
  end
end

function goodNoteHit(membersIndex, noteData, noteType, isSustainNote)
  for i = noteR[1], noteR[2], 1 do
    if i > 3 then
      if noteData == (i-4) and isSustainNote then
        local i_s = tostring(i)
        setProperty(i_s..".visible", true)
        setProperty(i_s..".alpha", ni(i, "alpha"))
        runTimer(i_s, stepCrochet/1000)
        setObjectOrder(i_s, 99)
        if not HSpashes["note"..i_s]["isPlaying"] then
          playAnim(i_s, i_s)
          HSpashes["note"..i_s]["isPlaying"] = false
        end
      end
    end
  end
end

function onUpdate()
  for i = 0, getProperty('grpNoteSplashes.length')-1 do
    setPropertyFromGroup('grpNoteSplashes', i, 'offset.x', -10)
    setPropertyFromGroup('grpNoteSplashes', i, 'offset.y', -10)
  end
end

function opponentNoteHit(membersIndex, noteData, noteType, isSustainNote)
  for i = noteR[1], noteR[2], 1 do
    if i < 4 then
      if noteData == (i) and isSustainNote then
        local i_s = tostring(i)
        setObjectOrder(i_s, 99)
        setProperty(i_s..".visible", true)
        setProperty(i_s..".alpha", ni(i, "alpha"))
        runTimer(i_s, stepCrochet/1000)
        if not HSpashes["note"..i_s]["isPlaying"] then
          playAnim(i_s, i_s)
          HSpashes["note"..i_s]["isPlaying"] = false
        end
      end
    end
  end
end

function onTimerCompleted(tag)
  for i = noteR[1], noteR[2], 1 do
    local i_s = tostring(i)
    if tag == i_s then
      setObjectOrder(i_s, 99)
      HSpashes["note"..i_s]["isPlaying"] = false
      HSpashes["note"..i_s]["Boom"] = true
      if i > 3 then
        playAnim(i_s, i_s.."p")
      else
        setProperty(i_s..".visible", false)
        HSpashes["note"..i_s]["Boom"] = false
      end
    end
  end
end

function onUpdatePost()
  if BoomRed then
    if getProperty('3.animation.curAnim.finished') then
      setProperty("3.visible", false)
      BoomRed = false
    end
  end
  for i = noteR[1], noteR[2], 1 do
    local i_s = tostring(i)
    if getProperty(i_s..".x") ~= ni(i, "x") - 110 then
      setProperty(i_s..'.x', ni(i, "x") - 110)
    end
    if getProperty(i_s..".y") ~= ni(i, "y") - 100 then
      setProperty(i_s..'.y', ni(i, "y") - 100)
    end
    if HSpashes["note"..i_s]["Boom"] then
      if getProperty(i_s..'.animation.curAnim.finished') then
        setProperty(i_s..".visible", false)
        HSpashes["note"..i_s]["Boom"] = false
      end
    end
  end
end

function ni(note, info)
  if getProperty('characterPlayingAsDad') == true then
    local noteMap = {4, 5, 6, 7, 0, 1, 2, 3}
    note = noteMap[note + 1] or note
  end
  return getPropertyFromGroup('strumLineNotes', note, info)
end
