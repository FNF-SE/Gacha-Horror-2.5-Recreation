function onCreatePost()
    makeLuaText("Captions", "", 1200, 55, 515)
    setTextSize("Captions", 30)
    setTextBorder("Captions", 2, "30AAEE")
    setTextColor("Captions", "D7E274")
    setTextFont("Captions", "Comfortaa-Bold.ttf")
    setTextAlignment("Captions", "center")
    addLuaText("Captions", true)
end

function onStepHit()
    if curStep == 1522 then
        setTextString("Captions", "We aren't")
    end
    if curStep == 1530 then
        setTextString("Captions", "DONE!")
    end
    if curStep == 1536 then
        setTextString("Captions", "")
    end
    if curStep == 1936 then
        setTextString("Captions", "Why are you here?")
    end
    if curStep == 1955 then
        setTextString("Captions", "Just to teach a traitor a lesson...")
        setTextColor("Captions", "3E4D68")
    end
    if curStep == 1984 then
        setTextString("Captions", "")
    end
end
