function onStepHit()
  if curStep == 768 then
    runHaxeCode([[PlayState.instance.changeNoteSkin(false, "noteSkins/NOTE_assets");]])
  elseif curStep == 1024 then
    runHaxeCode([[PlayState.instance.changeNoteSkin(false, "noteSkins/CCArrows");]])
  end
end
