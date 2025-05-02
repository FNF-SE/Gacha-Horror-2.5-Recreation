function onEvent(name,value1,value2)
  if name == "Set Cam ZoomBoom" then
    if value2 == '' then
      setProperty("defaultCamZoom",value1)
    else
      doTweenZoom('camz','camGame',tonumber(value1),tonumber(value2),'circOut')
	end
  end
end

function onTweenCompleted(name)
  if name == 'camz' then
    setProperty("defaultCamZoom",getProperty('camGame.zoom'))
  end
end