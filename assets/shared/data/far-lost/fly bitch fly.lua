function onUpdate(elapsed)
  if boyfriendName == 'muu' then
    if curStep >= 0 then
      songPos = getSongPosition()
      local currentBeat = (songPos/2000)*(bpm/100)
      doTweenY(boyfriendTweenY, 'boyfriend', -250-100*math.sin((currentBeat*0.25)*math.pi),0.001)
    end
  end
end
