function onEvent(name, value1, value2)
  function opponentNoteHit(i, d, t, s)
    if guitarHeroSustains then
      if not s then
        if getProperty('health') > (value2 / 50) and getProperty('health') < (value1 / 50) then
          setProperty('health', (value2 / 50))
        elseif getProperty('health') > (value2 / 50) and getProperty('health') > (value1 / 50) then
          setProperty('health', getProperty('health')-(value1 / 50))
        end
      end
    else
      if getProperty('health') > (value2 / 50) and getProperty('health') < (value1 / 50) then
        setProperty('health', (value2 / 50))
      elseif getProperty('health') > (value2 / 50) and getProperty('health') > (value1 / 50) then
        setProperty('health', getProperty('health')-(value1 / 50))
      end
    end
  end
end
