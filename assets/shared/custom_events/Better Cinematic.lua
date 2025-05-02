--Created by RamenDominoes
--Modified by Homura Akemi (HomuHomu833)
HudAssets = {'healthBar','healthBar.bg','iconP1','iconP2','timeBar','timeBar.bg','accuracyBar','scoreBar','topBar','songName','accuracyTxt','scoreCTxt','durationTxt','missesTxt','songTxt'}
Index = 1

function onCreatePost()
  makeLuaSprite('UpperBar(Still Strum)', 'empty', -110, -350)
  makeGraphic('UpperBar(Still Strum)', 1500, 350, '000000')
  setObjectCamera('UpperBar(Still Strum)', 'HUD')
  addLuaSprite('UpperBar(Still Strum)', false)

  makeLuaSprite('LowerBar(Still Strum)', 'empty', -110, 720)
  makeGraphic('LowerBar(Still Strum)', 1500, 350, '000000')
  setObjectCamera('LowerBar(Still Strum)', 'HUD')
  addLuaSprite('LowerBar(Still Strum)', false)

  UpperBar = getProperty('UpperBar(Still Strum).y')
  LowerBar = getProperty('LowerBar(Still Strum).y')

  for Notes = 0,7 do
    StrumY = getPropertyFromGroup('strumLineNotes', Notes, 'y')
  end
end


function onEvent(name, value1, value2)
  if name == 'Better Cinematic' then
    Speed = tonumber(value1)
    Distance = tonumber(value2)

    if Speed and Distance > 0 then
      doTweenY('Still Strum1', 'UpperBar(Still Strum)', UpperBar + Distance, Speed, 'quadOut')
      doTweenY('Still Strum2', 'LowerBar(Still Strum)', LowerBar - Distance, Speed, 'quadOut')
      if botPlay then
        doTweenY('Botplay Thingie', 'botplayTxt', Distance + 63, Speed, 'quadOut')
      end

      for Alphas = 1,15 do
        doTweenAlpha('Alpha(Still Strum)'..Alphas, HudAssets[Index], 0, Speed - 0.1)
        Index = Index + 1

        if Index > #HudAssets then
          Index = 1
        end
      end
      noteTweenY("idk1", 0, defaultOpponentStrumY0 + Distance - 20, Speed, "quadOut")
      noteTweenY("idk2", 1, defaultOpponentStrumY1 + Distance - 20, Speed, "quadOut")
      noteTweenY("idk3", 2, defaultOpponentStrumY2 + Distance - 20, Speed, "quadOut")
      noteTweenY("idk4", 3, defaultOpponentStrumY3 + Distance - 20, Speed, "quadOut")
      noteTweenY("idk5", 4, defaultPlayerStrumY0 + Distance - 20, Speed, "quadOut")
      noteTweenY("idk6", 5, defaultPlayerStrumY1 + Distance - 20, Speed, "quadOut")
      noteTweenY("idk7", 6, defaultPlayerStrumY2 + Distance - 20, Speed, "quadOut")
      noteTweenY("idk8", 7, defaultPlayerStrumY3 + Distance - 20, Speed, "quadOut")
    end

    if downscroll and Speed and Distance > 0 then
      doTweenY('Still Strum1', 'UpperBar(Still Strum)', UpperBar + Distance, Speed, 'quadOut')
      doTweenY('Still Strum2', 'LowerBar(Still Strum)', LowerBar - Distance, Speed, 'quadOut')

      for Alphas = 1,15 do
        doTweenAlpha('Alpha(Still Strum)'..Alphas, HudAssets[Index], 0, Speed - 0.1)
        Index = Index + 1

        if Index > #HudAssets then
          Index = 1
        end
      end
      noteTweenY("idk1", 0, defaultOpponentStrumY0 - Distance + 20, Speed, "quadOut")
      noteTweenY("idk2", 1, defaultOpponentStrumY1 - Distance + 20, Speed, "quadOut")
      noteTweenY("idk3", 2, defaultOpponentStrumY2 - Distance + 20, Speed, "quadOut")
      noteTweenY("idk4", 3, defaultOpponentStrumY3 - Distance + 20, Speed, "quadOut")
      noteTweenY("idk5", 4, defaultPlayerStrumY0 - Distance + 20, Speed, "quadOut")
      noteTweenY("idk6", 5, defaultPlayerStrumY1 - Distance + 20, Speed, "quadOut")
      noteTweenY("idk7", 6, defaultPlayerStrumY2 - Distance + 20, Speed, "quadOut")
      noteTweenY("idk8", 7, defaultPlayerStrumY3 - Distance + 20, Speed, "quadOut")
    end

    if Distance <= 0 then
      doTweenY('Still Strum1', 'UpperBar(Still Strum)', UpperBar, Speed, 'quadIn')
      doTweenY('Still Strum2', 'LowerBar(Still Strum)', LowerBar, Speed, 'quadIn')
      if botPlay then
        doTweenY('Botplay Thingie', 'botplayTxt', 83, Speed, 'quadIn')
      end

      for Alphas = 1,15 do
        doTweenAlpha('Alpha(Still Strum)'..Alphas, HudAssets[Index], 1, Speed + 0.1)
        Index = Index + 1

        if Index > #HudAssets then
          Index = 1
        end
      end
      noteTweenY("idk1", 0, defaultOpponentStrumY0, Speed, "quadIn")
      noteTweenY("idk2", 1, defaultOpponentStrumY1, Speed, "quadIn")
      noteTweenY("idk3", 2, defaultOpponentStrumY2, Speed, "quadIn")
      noteTweenY("idk4", 3, defaultOpponentStrumY3, Speed, "quadIn")
      noteTweenY("idk5", 4, defaultPlayerStrumY0, Speed, "quadIn")
      noteTweenY("idk6", 5, defaultPlayerStrumY1, Speed, "quadIn")
      noteTweenY("idk7", 6, defaultPlayerStrumY2, Speed, "quadIn")
      noteTweenY("idk8", 7, defaultPlayerStrumY3, Speed, "quadIn")
    end
  end
end
